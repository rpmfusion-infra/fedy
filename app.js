#!/usr/bin/gjs

const Gio = imports.gi.Gio;
const GLib = imports.gi.GLib;
const Gtk = imports.gi.Gtk;
const Pango = imports.gi.Pango;
const Lang = imports.lang;
const Mainloop = imports.mainloop;

const Application = new Lang.Class({
    Name: "Fedy",

    _init: function() {
        this.application = new Gtk.Application({
            application_id: "org.ozonos.fedy",
            flags: Gio.ApplicationFlags.FLAGS_NONE
        });

        this.application.connect("activate", Lang.bind(this, this._onActivate));
        this.application.connect("startup", Lang.bind(this, this._onStartup));
    },

    _buildUI: function() {
        this._window = new Gtk.ApplicationWindow({
                            application: this.application,
                            window_position: Gtk.WindowPosition.CENTER,
                            title: "Fedy"
                        });

        try {
            let icon = Gtk.IconTheme.get_default().load_icon("fedy", 48, 0);

            this._window.set_icon(icon);
        } catch (e) {
            print("Failed to load application icon: " + e.message);
        }

        this._headerbar = new Gtk.HeaderBar({ show_close_button: true });

        this._renderPlugins();

        this._window.set_default_size(800, 600);
        this._window.set_titlebar(this._headerbar);
        this._window.show_all();
    },

    _onActivate: function() {
        this._window.present();
    },

    _onStartup: function() {
        this._loadPlugins();
        this._buildUI();
    },

    _loadJSON: function(path) {
        let parsed;

        let file = Gio.File.new_for_path(path);

        if (file.query_exists(null)) {
            let size = file.query_info("standard::size",
                                       Gio.FileQueryInfoFlags.NONE,
                                       null).get_size();

            try {
                let stream = file.open_readwrite(null).get_input_stream();
                let data = stream.read_bytes(size, null).get_data();

                stream.close(null);

                parsed = JSON.parse(data);
            } catch (e) {
                print("Error loading file " + file.get_path() + " : " + e.message);
            }
        }

        return parsed;
    },

    _executeCommand: function(workingdir, command, callback = () => {}) {
        let [ status, argvp ] = GLib.shell_parse_argv(command);

        if (status === false) {
            callback(null, 1);
        }

        let envp = GLib.get_environ();

        let currdir = GLib.get_current_dir();

        let path = GLib.environ_getenv(envp, "PATH");

        envp = GLib.environ_setenv(envp, "PATH", path + ":" + currdir + "/bin", true);

        let ok, pid;

        try {
            [ ok, pid ] = GLib.spawn_async(workingdir, argvp, envp,
                                       GLib.SpawnFlags.SEARCH_PATH_FROM_ENVP | GLib.SpawnFlags.DO_NOT_REAP_CHILD, null);
        } catch (e) {
            print("Failed to run process: " + e.message);

            callback(null, 1, e);
        }

        if (ok === false) {
            callback(pid, 1);

            return;
        }

        if (typeof pid === "number") {
            GLib.child_watch_add(GLib.PRIORITY_DEFAULT, pid, (...args) => {
                GLib.spawn_close_pid(pid);

                callback.apply(this, args);
            });
        }
    },

    _queueCommand: function(...args) {
        function run(wd, cmd, cb) {
            this._executeCommand(wd, cmd, (...a) => {
                cb.apply(this, a);

                this._queue.splice(0, 1);

                if (this._queue.length) {
                    run.apply(this, this._queue[0]);
                }
            });
        }

        this._queue = this._queue || [];

        this._queue.push(args);

        if (this._queue.length === 1) {
            run.apply(this, args);
        }
    },

    _getPluginStatus: function(plugin, callback) {
        if (typeof callback !== "function") {
            return;
        }

        let scripts = plugin.scripts;

        if (scripts.status && scripts.status.command) {
            this._executeCommand(plugin.path, scripts.status.command, (pid, status) => {
                if (status === 0) {
                    callback(scripts.undo, status);
                } else {
                    callback(scripts.exec, status);
                }
            });
        } else {
            callback(scripts.exec, 1);
        }
    },

    _setButtonState: function(button, plugin) {
        this._getPluginStatus(plugin, (action, status) => {
            button.set_label(action.label);

            if (status === 0) {
                button.get_style_context().add_class("destructive-action");
            } else {
                button.get_style_context().add_class("suggested-action");
            }

            button.set_sensitive(!!action.command);
        });
    },

    _handleTask: function(button, spinner, plugin) {
        spinner.start();

        button.set_label("Working...");
        button.get_style_context().remove_class("suggested-action");
        button.get_style_context().remove_class("destructive-action");
        button.set_sensitive(false);

        this._getPluginStatus(plugin, (action) => {
            this._queueCommand(plugin.path, action.command, (pid, status) => {
                spinner.stop();

                if (status === 0) {
                    button.set_label("Finished!");
                } else {
                    button.set_label("Error!");
                }

                Mainloop.timeout_add(1000, () => {
                    this._setButtonState(button, plugin);

                    return false;
                }, null);
            });
        });
    },

    _renderPlugins: function() {
        let stack = new Gtk.Stack({ transition_type: Gtk.StackTransitionType.CROSSFADE });
        let switcher = new Gtk.StackSwitcher({ stack: stack });

        this._panes = {};

        let categories = Object.keys(this._plugins).sort();

        for (let category of categories) {
            this._panes[category] = new Gtk.ScrolledWindow();

            let list = new Gtk.ListBox({ selection_mode: Gtk.SelectionMode.NONE });

            list.get_style_context().add_class("view");

            for (let item in this._plugins[category]) {
                let plugin = this._plugins[category][item];

                let grid = new Gtk.Grid({
                    row_spacing: 5,
                    column_spacing: 10,
                    margin: 5
                });

                let image = new Gtk.Image();

                image.set_pixel_size(48);

                if (plugin.icon) {
                    try {
                        let icon = Gtk.IconTheme.get_default().load_icon (plugin.icon, 48, 0);

                        image.set_from_pixbuf (icon);
                    } catch (e) {
                        let icon;

                        let formats = [ "", ".svg", ".png" ];

                        for (let ext of formats) {
                            let path = plugin.path + "/" + plugin.icon + ext;

                            if (Gio.File.new_for_path(path).query_exists(null)) {
                                icon = path;

                                break;
                            }
                        }

                        if (icon) {
                            image.set_from_file(icon);
                        } else {
                            image.set_from_icon_name(plugin.icon, Gtk.IconSize.DIALOG);
                        }
                    }
                } else {
                    image.set_from_icon_name("system-run", Gtk.IconSize.DIALOG);
                }

                grid.attach(image, 0, 1, 1, 2);

                let label = new Gtk.Label({
                    halign: Gtk.Align.START,
                    expand: true
                });

                label.set_markup("<b>" + plugin.label + "</b>");

                grid.attach(label, 1, 1, 1, 1);

                let description = new Gtk.Label({
                    label: plugin.description,
                    halign: Gtk.Align.START,
                    expand: true
                });

                description.set_ellipsize(Pango.EllipsizeMode.END);
                description.set_has_tooltip(true);

                description.connect("query_tooltip", (l, x, y, k, tip) => {
                    if (l.get_layout().is_ellipsized()) {
                        tip.set_text(plugin.description);

                        return true;
                    }

                    return false;
                });

                grid.attach(description, 1, 2, 1, 1);

                if (plugin.scripts) {
                    if (plugin.scripts.exec) {
                        let spinner = new Gtk.Spinner({ active: false });

                        grid.attach(spinner, 2, 1, 1, 2);

                        let box = new Gtk.Box({
                            orientation: Gtk.Orientation.VERTICAL,
                            halign: Gtk.Align.END
                        });

                        let button = new Gtk.Button({
                            label: plugin.scripts.exec.label,
                            sensitive: false
                        });

                        this._setButtonState(button, plugin);

                        button.connect("clicked", Lang.bind(this, this._handleTask, spinner, plugin));

                        box.set_center_widget(button);

                        grid.attach(box, 3, 1, 1, 2);
                    }

                    if (plugin.scripts.show && plugin.scripts.show.command) {
                        this._executeCommand(plugin.path, plugin.scripts.show.command, (pid, status) => {
                            grid.set_visible(status === 0);
                        });
                    }
                }

                list.add(grid);
            }

            this._panes[category].add(list);

            stack.add_titled(this._panes[category], category, category);
        }

        this._headerbar.set_custom_title(switcher);
        this._window.add(stack);
    },

    _loadPlugins: function() {
        this._plugins = {};

        let currdir = GLib.get_current_dir();

        let plugindir = currdir + "/plugins";

        let dir = Gio.File.new_for_path(plugindir);

        let fileEnum;

        try {
            fileEnum = dir.enumerate_children("standard::name,standard::type",
                                              Gio.FileQueryInfoFlags.NONE, null);
        } catch (e) {
            fileEnum = null;
        }

        if (fileEnum !== null) {
            let info;

            while ((info = fileEnum.next_file(null)) !== null) {
                let name = info.get_name();

                if (/.*\.plugin$/.test(name)) {
                    let parsed = this._loadJSON(plugindir + "/" + name + "/metadata.json");

                    if (parsed && parsed.category) {
                        this._plugins[parsed.category] = this._plugins[parsed.category] || {};

                        let plugin = name.replace(/\.plugin$/, "");

                        this._plugins[parsed.category][plugin] = parsed;
                        this._plugins[parsed.category][plugin].path = plugindir + "/" + name;
                    }
                }
            }
        }
    }
});

let app = new Application();

app.application.run(ARGV);
