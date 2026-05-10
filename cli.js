// CLI interface - handles --list, --add, --remove, --status, --force options

import GLib from 'gi://GLib';
import { Option } from './option.js';
import { PluginRepository } from './repository.js';

// Available CLI options
const OPTS = {
    LIST:    new Option('list',    GLib.OptionArg.NONE,         'List available plugins',       null,       false),
    ONELINE: new Option('oneline', GLib.OptionArg.NONE,         'One-line plugin descriptions', null,       false),
    STATUS:  new Option('status',  GLib.OptionArg.STRING_ARRAY, 'Report plugin status',         '<plugin>', true),
    ADD:     new Option('add',     GLib.OptionArg.STRING_ARRAY, 'Add a plugin',                 '<plugin>', true),
    REMOVE:  new Option('remove',  GLib.OptionArg.STRING_ARRAY, 'Remove a plugin',              '<plugin>', true),
    FORCE:   new Option('force',   GLib.OptionArg.NONE,         'Force plugin action',          null,       false),
};
const ALL_OPTS = Object.values(OPTS);

// Represents a pending user action on a plugin
class PluginAction {
    constructor(option, plugin, forced) {
        this.option = option;
        this.plugin = plugin;
        this.forced = forced;
    }

    get actionLabel() {
        return this.option.name.charAt(0).toUpperCase() + this.option.name.slice(1);
    }

    get pluginLabel() {
        return this.isUnknown ? this.plugin.name : this.plugin.label;
    }

    get isUnknown() {
        return typeof this.plugin.label === 'undefined';
    }

    get isStatus() {
        return OPTS.STATUS.match(this.option.name);
    }

    get isCommand() {
        return !this.isUnknown && !this.isStatus;
    }
}

export class FedyCli {
    constructor(app) {
        this.app = app;

        // Register all options on the GtkApplication
        ALL_OPTS.forEach(opt => opt.registerIn(app.application));

        if (typeof app.application.set_option_context_summary !== 'undefined') {
            app.application.set_option_context_parameter_string('app.js');
            app.application.set_option_context_description('');
            app.application.set_option_context_summary(
                '  fedy --list [--oneline]\n' +
                '  fedy [--force] [--status <plugin>]... [--remove <plugin>]... [--add <plugin>]...'
            );
        }

        app.application.connect('handle_local_options', (_application, options) => {
            return this._onOptions(options);
        });
    }

    // Returns -1 to continue to GUI, 0 to exit after CLI handling
    _onOptions(options) {
        if (!ALL_OPTS.some(opt => opt.in(options))) return -1;

        this.app.loadConfig();
        this.app.loadPlugins();
        const runner = this.app.createCommandRunner();
        this._repo = new PluginRepository(this.app.plugins, runner);

        const loop = GLib.MainLoop.new(null, false);
        const promises = OPTS.LIST.in(options)
            ? this._categoryReports(options)
            : this._actionReports(options);

        Promise.all(promises)
            .then(reports => this._print(reports))
            .then(() => loop.quit());

        loop.run();
        return 0;
    }

    // --- List mode ---

    _categoryReports(options) {
        const oneline = OPTS.ONELINE.in(options);
        return this._repo.listCategories().map(category => {
            const statusPromises = this._repo.listByCategory(category).map(plugin =>
                this._repo.promiseOfPluginStatus(plugin).then(s => [plugin, s])
            );
            return Promise.all(statusPromises).then(entries =>
                this._formatCategory(category, entries, oneline)
            );
        });
    }

    _formatCategory(category, entries, oneline) {
        let report = `Category: ${category}\n`;
        for (const [plugin, status] of entries) {
            const mark = status.isPluginEnable() ? '\u2713' : '\u2717';
            report += `${mark} [${plugin.name}] ${plugin.label}\n`;
            if (!oneline) {
                report += `  ${plugin.description}\n`;
                if (plugin.license) report += `  (${plugin.license})\n`;
            }
        }
        return report + '\n';
    }

    // --- Action mode (add/remove/status) ---

    _actionReports(options) {
        const forced = OPTS.FORCE.in(options);
        return ALL_OPTS
            .filter(opt => opt.in(options) && opt.isAction)
            .flatMap(opt => opt.parameters(options).map(name => {
                const plugin = this._repo.getByName(name);
                return new PluginAction(opt, plugin, forced);
            }))
            .map(action => this._resolveAction(action));
    }

    _resolveAction(action) {
        return this._repo.promiseOfPluginStatus(action.plugin).then(status => {
            if (!this._needsExecution(action, status)) {
                return this._formatResult(action, status, 0);
            }
            return this._repo
                .promiseOfCommandStatus(action.plugin.path, status.action.command)
                .then(code => this._formatResult(action, status, code));
        }).catch(e => console.error(e));
    }

    _needsExecution(action, status) {
        const done = this._alreadyApplied(action, status);
        return !done && action.isCommand && (!status.isMalicious || action.forced);
    }

    _alreadyApplied(action, status) {
        if (OPTS.ADD.match(action.option.name)) return status.code === 0;
        if (OPTS.REMOVE.match(action.option.name)) return status.code !== 0;
        return false;
    }

    _formatResult(action, status, exitCode) {
        const prefix = `${action.actionLabel} of '${action.pluginLabel}'`;

        if (action.isUnknown) return `\u2717 ${prefix} fail: plugin name unknown`;
        if (action.isStatus) return `\u2713 ${prefix} ${status.isPluginEnable() ? 'enabled' : 'disabled'}`;
        if (this._alreadyApplied(action, status)) return `\u2713 ${prefix} already done`;

        if (status.isMalicious && !action.forced) {
            return `\u2717 ${prefix} aborted: plugin tries to run '${status.maliciousPart}' ` +
                `which might ${status.maliciousDescription}. Use -f to force.`;
        }

        return exitCode === 0
            ? `\u2713 ${prefix} (${status.action.label}) successfully completed`
            : `\u2717 ${prefix} (${status.action.label}) failed`;
    }

    _print(reports) {
        console.log('\n-------');
        reports.forEach(r => console.log(r));
    }
}
