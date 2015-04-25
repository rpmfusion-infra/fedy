#!/usr/bin/gjs

const Gio = imports.gi.Gio;
const GLib = imports.gi.GLib;
const Gtk = imports.gi.Gtk;
const Lang = imports.lang;

const Application = new Lang.Class({
    Name: "Ozon toolbox",

    _init: function() {
        this.application = new Gtk.Application({
            application_id: "org.ozonos.toolbox",
            flags: Gio.ApplicationFlags.FLAGS_NONE
        });

        this.application.connect("activate", Lang.bind(this, this._onActivate));
        this.application.connect("startup", Lang.bind(this, this._onStartup));
    },

    _buildUI: function() {
        this._window = new Gtk.ApplicationWindow({
                            application: this.application,
                            window_position: Gtk.WindowPosition.CENTER,
                            title: "Ozon toolbox"
                        });

        this._createHeaderbar();

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

    _createHeaderbar: function() {
        this._headerbar = new Gtk.HeaderBar({ show_close_button: true });

        let buttonbox = new Gtk.ButtonBox({
            orientation: Gtk.Orientation.HORIZONTAL,
            homogeneous: true
        });

        buttonbox.get_style_context().add_class("linked");

        let categories = [];

        for (var plugin in this._plugins) {
            let p = this._plugins[plugin];

            if (p.category && categories.indexOf(p.category) === -1) {
                categories.push(p.category);
            }
        }

        let group;

        for (var i = 0, l = categories.length; i < l; i++) {
            let b;

            if (group) {
                b = new Gtk.RadioButton({
                    label: categories[i],
                    group: group
                });
            } else {
                group = b = new Gtk.RadioButton({ label: categories[i] });
            }

            buttonbox.add(b);

            b.set_mode(false);
            b.show();
        }

        this._headerbar.set_custom_title(buttonbox);
    },

    _loadPlugins: function() {
        this._plugins = {};

        let currdir = GLib.get_current_dir();

        let plugindir = currdir + "/plugins";

        let dir = Gio.File.new_for_path(plugindir);

        let fileEnum;

        try {
            fileEnum = dir.enumerate_children('standard::name,standard::type',
                                              Gio.FileQueryInfoFlags.NONE, null);
        } catch (e) {
            fileEnum = null;
        }


        if (fileEnum !== null) {
            let info;

            while ((info = fileEnum.next_file(null)) !== null) {
                let name = info.get_name();

                if (/.*\.plugin$/.test(name)) {
                    let file = Gio.File.new_for_path(plugindir + "/" + name + "/metadata.json");

                    if (!file.query_exists(null)) {
                        continue;
                    }

                    let size = file.query_info("standard::size",
                                               Gio.FileQueryInfoFlags.NONE,
                                               null).get_size();

                    try {
                        let stream = file.open_readwrite(null).get_input_stream();
                        let data = stream.read_bytes(size, null).get_data();

                        stream.close(null);

                        let plugin = name.replace(/\.plugin$/, "");

                        this._plugins[plugin] = JSON.parse(data);
                    } catch (e) {
                        print("Error loading plugin " + name + " : " + e.message);
                    }
                }
            }
        }
    }
});

let app = new Application();

app.application.run(ARGV);
