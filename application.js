// Fedy application lifecycle - config loading, plugin discovery, startup/activate

import GLib from 'gi://GLib';
import Gio from 'gi://Gio';
import Gtk from 'gi://Gtk?version=4.0';
import Notify from 'gi://Notify';

import { loadJSON, deepMerge } from './utils.js';
import { CommandRunner } from './commandRunner.js';
import { FedyWindow } from './window.js';
import { FedyCli } from './cli.js';

const APP_NAME = 'Fedy';

// Derive app directory from module URL instead of relying on CWD
const APP_DIR = GLib.path_get_dirname(import.meta.url.slice(7));

export class FedyApplication {
    constructor() {
        this.application = new Gtk.Application({
            application_id: 'org.rpmfusion.fedy',
            flags: Gio.ApplicationFlags.FLAGS_NONE,
        });

        this.config = {};
        this.plugins = {};

        // CLI must register options before run()
        this.cli = new FedyCli(this);

        this.application.connect('startup', () => this._onStartup());
        this.application.connect('activate', () => this._onActivate());

        Notify.init(APP_NAME);
    }

    run(args) {
        this.application.run(args);
    }

    // Load system and user config, merge user overrides
    loadConfig() {
        const system = loadJSON(`${APP_DIR}/config.json`);
        const user = loadJSON(`${GLib.get_user_data_dir()}/fedy/config.json`);
        this.config = {};
        deepMerge(this.config, system, user);
    }

    // Discover plugins from system and user directories
    loadPlugins() {
        const system = this._scanPluginDir(`${APP_DIR}/plugins`);
        const user = this._scanPluginDir(`${GLib.get_user_data_dir()}/fedy/plugins`);
        this.plugins = {};
        deepMerge(this.plugins, system, user);
    }

    // Create a command runner with current config
    createCommandRunner() {
        return new CommandRunner(APP_DIR, this.config);
    }

    _onStartup() {
        this.loadConfig();
        this.loadPlugins();
        this._commandRunner = this.createCommandRunner();
        this._window = new FedyWindow(this.application, this.plugins, this._commandRunner);
    }

    _onActivate() {
        this._window.present();
    }

    // Scan a directory for .plugin folders containing metadata.json
    _scanPluginDir(dirPath) {
        const plugins = {};
        const dir = Gio.File.new_for_path(dirPath);

        let enumerator;
        try {
            enumerator = dir.enumerate_children(
                'standard::name,standard::type', Gio.FileQueryInfoFlags.NONE, null
            );
        } catch {
            return plugins;
        }

        let info;
        while ((info = enumerator.next_file(null)) !== null) {
            const name = info.get_name();
            if (!name.endsWith('.plugin')) continue;

            const metadata = loadJSON(`${dirPath}/${name}/metadata.json`);
            if (!metadata?.category) continue;

            const pluginId = name.replace(/\.plugin$/, '');
            plugins[metadata.category] = plugins[metadata.category] || {};
            plugins[metadata.category][pluginId] = metadata;
            plugins[metadata.category][pluginId].path = `${dirPath}/${name}`;
        }

        return plugins;
    }
}
