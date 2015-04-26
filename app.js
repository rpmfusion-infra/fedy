#!/usr/bin/gjs

const Gio = imports.gi.Gio;
const GLib = imports.gi.GLib;
const Gtk = imports.gi.Gtk;
const Gdk = imports.gi.Gdk;
const Pango = imports.gi.Pango;
const Lang = imports.lang;

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

    _handleTask: function(event, plugin) {
        let script = plugin.path  + "/" + plugin.scripts[plugin.action];

        let file = Gio.File.new_for_path(script);

        if (file.query_exists(null)) {
            try {
                GLib.spawn_command_line_async("sh " + script);
            } catch (e) {
                print("Failed to run process: " + e.message);
            }
        }
    },

    _renderPlugins: function() {
        let stack = new Gtk.Stack({ transition_type: Gtk.StackTransitionType.CROSSFADE });
        let switcher = new Gtk.StackSwitcher({ stack: stack });

        this._panes = {};

        let categories = Object.keys(this._plugins).sort();

        for (let category of categories) {
            this._panes[category] = new Gtk.ScrolledWindow();

            let list = new Gtk.ListBox({ selection_mode: Gtk.SelectionMode.NONE });

            for (let item in this._plugins[category]) {
                let plugin = this._plugins[category][item];

                let grid = new Gtk.Grid({
                    row_spacing: 5,
                    column_spacing: 10,
                    margin: 5
                });

                let image = new Gtk.Image();

                if (plugin.icon) {
                    if (/^\.\/.*/.test(plugin.icon)) {
                        image.set_from_file(plugin.path + "/" + plugin.icon);
                    } else {
                        image.set_from_icon_name(plugin.icon, Gtk.IconSize.DIALOG);
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
                label.set_ellipsize(Pango.EllipsizeMode.END);

                grid.attach(label, 1, 1, 1, 1);

                let description = new Gtk.Label({
                    label: plugin.description,
                    halign: Gtk.Align.START,
                    expand: true
                });

                description.set_ellipsize(Pango.EllipsizeMode.END);

                grid.attach(description, 1, 2, 1, 1);

                if (plugin.action) {
                    let box = new Gtk.Box({
                        orientation: Gtk.Orientation.VERTICAL,
                        halign: Gtk.Align.END
                    });

                    let button = new Gtk.Button({ label: plugin.action });

                    button.connect("clicked", Lang.bind(this, this._handleTask, plugin));

                    box.set_center_widget(button);

                    grid.attach(box, 2, 1, 1, 2);
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
