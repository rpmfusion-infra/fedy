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
        this._buildUI();
    },

    _createHeaderbar: function() {
        this._headerbar = new Gtk.HeaderBar({ show_close_button: true });

        let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL });

        let buttonbox = new Gtk.ButtonBox({
            orientation: Gtk.Orientation.HORIZONTAL,
            homogeneous: true
        });

        buttonbox.get_style_context().add_class("linked");

        let buttons = {
            tweaks: {
                label: "Tweaks",
                action: function() {
                    print("You clicked 'New'.");
                }
            },
            apps: {
                label: "Apps",
                action: function() {}
            }
        };

        let group;

        for (let cat in buttons) {
            let b;

            if (group) {
                b = new Gtk.RadioButton({
                    label: buttons[cat].label,
                    group: group
                });
            } else {
                group = b = new Gtk.RadioButton({ label: buttons[cat].label });
            }

            buttonbox.add(b);

            b.set_mode(false);
            b.show();
        }

        hbox.add(buttonbox);

        this._headerbar.add(hbox);
    }
});

let app = new Application();

app.application.run(ARGV);
