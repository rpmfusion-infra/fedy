// Main application window - plugin list UI with search, actions, and notifications

import GLib from 'gi://GLib';
import Gio from 'gi://Gio';
import Gtk from 'gi://Gtk?version=4.0';
import Notify from 'gi://Notify';
import Pango from 'gi://Pango';

const APP_NAME = 'Fedy';

export class FedyWindow {
    constructor(application, plugins, commandRunner) {
        this.plugins = plugins;
        this.commandRunner = commandRunner;
        this._listboxes = [];
        this._allRows = [];

        this._window = new Gtk.ApplicationWindow({
            application,
            title: APP_NAME,
            default_width: 800,
            default_height: 600,
        });

        this._buildHeaderBar();
        this._buildPluginStack();
        this._buildSearchResults();
        this._buildSearch();
        this._assembleLayout();

        // Hide instead of close while tasks are queued
        this._window.connect('close-request', () => {
            if (this.commandRunner.queueLength > 0) {
                this._window.set_visible(false);
                return true;
            }
            return false;
        });
    }

    present() {
        this._window.present();
    }

    // --- UI Construction ---

    _buildHeaderBar() {
        this._headerbar = new Gtk.HeaderBar({ show_title_buttons: true });
        this._window.set_titlebar(this._headerbar);
    }

    _buildPluginStack() {
        this._stack = new Gtk.Stack({
            transition_type: Gtk.StackTransitionType.CROSSFADE,
            vexpand: true,
        });

        const categories = Object.keys(this.plugins).sort();

        // Title widget: plain label for 0-1 categories, switcher for multiple
        if (categories.length <= 1) {
            this._headerbar.set_title_widget(
                new Gtk.Label({ label: categories[0] || APP_NAME })
            );
        } else {
            this._headerbar.set_title_widget(
                new Gtk.StackSwitcher({ stack: this._stack })
            );
        }

        for (const category of categories) {
            const list = new Gtk.ListBox({ selection_mode: Gtk.SelectionMode.NONE });
            list.add_css_class('view');
            list.set_sort_func((a, b) => a._sortKey.localeCompare(b._sortKey));
            this._listboxes.push(list);

            for (const name in this.plugins[category]) {
                const plugin = this.plugins[category][name];
                console.log(`fedy: loading ${plugin.category}::${plugin.label}`);
                this._addPluginRow(list, plugin);
            }

            const scrolled = new Gtk.ScrolledWindow({ child: list });
            this._stack.add_titled(scrolled, category, category);
        }
    }

    _addPluginRow(list, plugin) {
        const grid = new Gtk.Grid({
            row_spacing: 5,
            column_spacing: 10,
            margin_start: 5,
            margin_end: 5,
            margin_top: 5,
            margin_bottom: 5,
        });

        // Icon
        grid.attach(this._createPluginIcon(plugin), 0, 0, 1, 2);

        // Name (bold)
        const nameLabel = new Gtk.Label({ halign: Gtk.Align.START, use_markup: true });
        nameLabel.set_markup(`<b>${GLib.markup_escape_text(plugin.label, -1)}</b>`);
        grid.attach(nameLabel, 1, 0, 1, 1);

        // License
        const licenseLabel = new Gtk.Label({ halign: Gtk.Align.START, hexpand: true });
        if (plugin.license) {
            const text = Array.isArray(plugin.license) ? plugin.license.join(', ') : plugin.license;
            licenseLabel.set_text(text);
            licenseLabel.set_opacity(0.7);
        }
        grid.attach_next_to(licenseLabel, nameLabel, Gtk.PositionType.RIGHT, 1, 1);

        // Description with ellipsis tooltip
        const descLabel = new Gtk.Label({
            label: plugin.description,
            halign: Gtk.Align.START,
            hexpand: true,
            ellipsize: Pango.EllipsizeMode.END,
        });
        descLabel.set_has_tooltip(true);
        descLabel.connect('query-tooltip', (lbl, _x, _y, _kb, tip) => {
            if (lbl.get_layout().is_ellipsized()) {
                tip.set_text(plugin.description);
                return true;
            }
            return false;
        });
        grid.attach(descLabel, 1, 1, 2, 1);

        // Action button + spinner
        if (plugin.scripts?.exec) {
            const spinner = new Gtk.Spinner();
            grid.attach(spinner, 2, 0, 1, 2);

            const button = new Gtk.Button({
                label: plugin.scripts.exec.label,
                sensitive: false,
                valign: Gtk.Align.CENTER,
            });
            this._refreshButtonState(button, plugin);
            button.connect('clicked', () => this._onAction(button, spinner, plugin));
            grid.attach(button, 3, 0, 1, 2);
        }

        list.append(grid);

        // Attach sort/filter metadata to the auto-created ListBoxRow
        const row = grid.get_parent();
        row._sortKey = plugin.label;
        row._searchText = `${plugin.label} ${plugin.description}`.toLowerCase();

        // Conditionally hide based on show script
        if (plugin.scripts?.show?.command) {
            this.commandRunner.execute(plugin.path, plugin.scripts.show.command, (_pid, status) => {
                row.set_visible(status === 0);
            });
        }
    }

    _createPluginIcon(plugin) {
        const image = new Gtk.Image({ pixel_size: 48 });

        if (plugin.icon) {
            // Try system icon theme first
            const theme = Gtk.IconTheme.get_for_display(this._window.get_display());
            if (theme.has_icon(plugin.icon)) {
                image.set_from_icon_name(plugin.icon);
                return image;
            }

            // Fall back to file in plugin directory
            for (const ext of ['', '.svg', '.png']) {
                const path = `${plugin.path}/${plugin.icon}${ext}`;
                if (Gio.File.new_for_path(path).query_exists(null)) {
                    image.set_from_file(path);
                    return image;
                }
            }
        }

        // Default fallback icon
        image.set_from_icon_name('system-run');
        return image;
    }

    // --- Global search results list (all plugins, flat) ---

    _buildSearchResults() {
        this._searchList = new Gtk.ListBox({ selection_mode: Gtk.SelectionMode.NONE });
        this._searchList.add_css_class('view');
        this._searchList.set_sort_func((a, b) => a._sortKey.localeCompare(b._sortKey));

        // Add a row for every plugin across all categories
        for (const category of Object.keys(this.plugins).sort()) {
            for (const name in this.plugins[category]) {
                const plugin = this.plugins[category][name];
                this._addPluginRow(this._searchList, plugin);
            }
        }

        this._searchScroll = new Gtk.ScrolledWindow({
            child: this._searchList,
            visible: false,
            vexpand: true,
            hexpand: true,
        });
    }

    // --- Search ---

    _buildSearch() {
        this._searchEntry = new Gtk.SearchEntry();
        this._searchBar = new Gtk.SearchBar({ child: this._searchEntry });
        this._searchBar.connect_entry(this._searchEntry);

        this._searchEntry.connect('search-changed', (entry) => {
            const text = entry.get_text().toLowerCase();

            if (text) {
                // Show flat search results across all categories
                this._stack.set_visible(false);
                this._searchScroll.set_visible(true);
                this._searchList.set_filter_func((row) => row._searchText.includes(text));
            } else {
                // Back to category tabs
                this._searchScroll.set_visible(false);
                this._stack.set_visible(true);
                this._searchList.set_filter_func(null);
            }
        });

        const searchButton = new Gtk.ToggleButton({ icon_name: 'edit-find-symbolic' });
        searchButton.connect('toggled', (btn) => {
            this._searchBar.set_search_mode(btn.get_active());
            // Reset when search is closed
            if (!btn.get_active()) {
                this._searchEntry.set_text('');
            }
        });
        this._headerbar.pack_end(searchButton);
    }

    _assembleLayout() {
        const vbox = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL });
        vbox.append(this._searchBar);
        vbox.append(this._stack);
        vbox.append(this._searchScroll);
        this._window.set_child(vbox);
    }

    // --- Plugin Actions ---

    _refreshButtonState(button, plugin) {
        this.commandRunner.getPluginStatus(plugin, (action, status) => {
            button.set_label(action.label);
            button.remove_css_class('suggested-action');
            button.remove_css_class('destructive-action');
            button.add_css_class(status === 0 ? 'destructive-action' : 'suggested-action');
            button.set_sensitive(!!action.command);
        });
    }

    _onAction(button, spinner, plugin) {
        spinner.start();
        button.set_label('Working...');
        button.remove_css_class('suggested-action');
        button.remove_css_class('destructive-action');
        button.set_sensitive(false);

        this.commandRunner.getPluginStatus(plugin, (action) => {
            this._runWithSafetyCheck(plugin, action.command, (pid, status) => {
                this._notify(plugin, action, status);

                // Auto-close if window was hidden and queue is drained
                if (!this._window.visible && this.commandRunner.queueLength === 0) {
                    this._window.close();
                    return;
                }

                spinner.stop();
                button.set_label(status === 0 ? 'Finished!' : 'Error!');

                GLib.timeout_add(GLib.PRIORITY_DEFAULT, 1000, () => {
                    this._refreshButtonState(button, plugin);
                    return false;
                });
            }, true);
        });
    }

    // Execute command after malicious pattern check, optionally queued
    _runWithSafetyCheck(plugin, command, callback = () => {}, queued = false) {
        const [malicious, malCmd, malDesc] = this.commandRunner.scanMalicious(plugin.path, command);

        if (malicious) {
            this._showMaliciousWarning(plugin, malCmd, malDesc, () => {
                this._dispatch(plugin.path, command, callback, queued);
            }, () => callback(null, 1));
            return;
        }

        this._dispatch(plugin.path, command, callback, queued);
    }

    _dispatch(path, command, callback, queued) {
        if (queued) {
            this.commandRunner.enqueue(path, command, callback);
        } else {
            this.commandRunner.execute(path, command, callback);
        }
    }

    _showMaliciousWarning(plugin, command, description, onConfirm, onCancel) {
        const dialog = new Gtk.AlertDialog({
            message: `Warning: ${plugin.label}`,
            detail: `This plugin is trying to run:\n${command}\n\nThis might ${description}.\n\nContinue anyway?`,
        });
        dialog.set_buttons(['Cancel', 'Continue']);
        dialog.set_cancel_button(0);
        dialog.set_default_button(0);

        dialog.choose(this._window, null, (_dlg, result) => {
            try {
                if (dialog.choose_finish(result) === 1) onConfirm();
                else onCancel();
            } catch {
                onCancel();
            }
        });
    }

    // --- Notifications ---

    _notify(plugin, action, status) {
        try {
            const ok = status === 0;
            const notification = new Notify.Notification({
                summary: `Task ${ok ? 'completed!' : 'failed!'}`,
                body: `${plugin.label} (${action.label}) ${ok ? 'successfully completed.' : 'failed.'}`,
                icon_name: 'fedy',
                id: this._hash(plugin.category + plugin.label),
            });

            if (!ok) notification.set_urgency(Notify.Urgency.CRITICAL);
            notification.set_timeout(1000);
            notification.show();
        } catch (e) {
            console.error(`Notification failed: ${e.message}`);
        }
    }

    _hash(str) {
        let h = 0;
        for (let i = 0; i < str.length; i++) h += str.charCodeAt(i);
        return h;
    }
}
