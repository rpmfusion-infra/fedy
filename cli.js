/* global print, logError */

const
    GLib = imports.gi.GLib,
    Lang = imports.lang,
    Option = imports.option.Option,
    PluginRepository = imports.repository.PluginRepository;

const
    FedyOption = {
        LIST: new Option("list", GLib.OptionArg.NONE, "List available plugins", null, false),
        ONELINE: new Option("oneline", GLib.OptionArg.NONE, "Render each plugin description on one line", null, false),
        STATUS: new Option("status", GLib.OptionArg.STRING_ARRAY, "Report plugin status", "<plugin>", true),
        ADD: new Option("add", GLib.OptionArg.STRING_ARRAY, "Add a plugin", "<plugin>", true),
        REMOVE: new Option("remove", GLib.OptionArg.STRING_ARRAY, "Remove a plugin", "<plugin>", true),
        FORCE: new Option("force", GLib.OptionArg.NONE, "Force plugins action", null, false)
    },
    FedyOptions = [
        FedyOption.LIST,
        FedyOption.ONELINE,
        FedyOption.STATUS,
        FedyOption.ADD,
        FedyOption.REMOVE,
        FedyOption.FORCE
    ];


var PluginAction = new Lang.Class({
    Name: "PluginAction",

    _init(option, plugin, forced) {
        this.option = option;
        this.plugin = plugin;
        this.forced = forced;
    },

    actionLabel() {
        return this.option.name.charAt(0).toUpperCase() + this.option.name.substr(1);
    },

    pluginLabel() {
        return (this.isPluginUnknown()) ? this.plugin.name : this.plugin.label;
    },

    isCommand() {
        return !this.isPluginUnknown() && !this.isStatus();
    },

    isPluginUnknown() {
        return typeof this.plugin.label === "undefined";
    },

    isStatus() {
        return FedyOption.STATUS.match(this.option.name);
    }
});

var FedyCli = new Lang.Class({
    Name: "FedyCli",

    _init(fedy) {
        FedyOptions.forEach(option => option.registerIn(fedy.application));

        this.fedy = fedy;

        if (typeof fedy.application.set_option_context_summary !== "undefined") {
            fedy.application.set_option_context_parameter_string("app.js");
            fedy.application.set_option_context_description("");
            fedy.application.set_option_context_summary(
                "  fedy --list [--oneline]\n" +
                "  fedy [--force] [--status <plugin>]... [--remove <plugin>]... [--add <plugin>]..."
            );
        }

        this.fedy.application.connect("handle_local_options", Lang.bind(this, this._onOptions));
    },

    _onOptions(application, options) {
        if (!this._isCliOptions(options)) {
            return -1;
        }

        this.pluginRepository = new PluginRepository(this.fedy);

        const loop = GLib.MainLoop.new(null, false);
        let promiseOfReports = (FedyOption.LIST.in(options)) ?
            this._promiseOfCategoryReports(options) :
            this._promiseOfActionReports(options);

        Promise
            .all(promiseOfReports)
            .then(reports => this._printReports(reports))
            .then(() => loop.quit());

        loop.run();

        return 0;
    },

    _isCliOptions(options) {
        return FedyOptions.some(option => option.in(options));
    },

    _promiseOfCategoryReports(options) {
        const oneline = FedyOption.ONELINE.in(options);
        return this.pluginRepository
            .listCategories()
            .map(category => {
                const promiseOfPluginsWithStatuses = this.pluginRepository
                    .listByCategory(category)
                    .map(plugin => this.pluginRepository
                        .promiseOfPluginStatus(plugin)
                        .then(pluginStatus => [ plugin, pluginStatus ]));

                return Promise
                    .all(promiseOfPluginsWithStatuses)
                    .then(pluginsWithStatuses => this._buildCategoryReport(category, pluginsWithStatuses, oneline));
            });
    },

    _buildCategoryReport(category, pluginsWithStatuses, oneline) {
        let report = `Category: ${category}\n`;
        pluginsWithStatuses.forEach(([ plugin, pluginStatus ]) => {
            report += this._buildPluginReport(plugin, pluginStatus, oneline);
        });
        report += "\n";
        return report;
    },

    _buildPluginReport(plugin, pluginStatus, oneline) {
        const statusCharacter = pluginStatus.isPluginEnable() ? "✓" : "✗",
            onelineReport = `${statusCharacter} [${plugin.name}] ${plugin.label}\n`,
            license = (typeof plugin.license !== "undefined") ? `  (${plugin.license})\n` : "";
        return (oneline) ? onelineReport : `${onelineReport}  ${plugin.description}\n${license}`;
    },

    _promiseOfActionReports: function (options) {
        const forced = FedyOption.FORCE.in(options);
        return FedyOptions
            .filter(option => option.in(options) && option.isAction)
            .flatMap(option => this._pluginActions(options, option, forced))
            .map(pluginActions => this._promiseOfActionReport(pluginActions));
    },

    _pluginActions(options, option, forced) {
        return option
            .parameters(options)
            .map(pluginName => {
                let plugin = this.pluginRepository.getByName(pluginName);
                return new PluginAction(option, plugin, forced);
            });
    },

    _promiseOfActionReport(pluginAction) {
        return this.pluginRepository
            .promiseOfPluginStatus(pluginAction.plugin)
            .then(pluginStatus => {
                if (!this._isCommandRequired(pluginAction, pluginStatus)) {
                    return this._buildReport(pluginAction, pluginStatus, 0);
                }

                return this.pluginRepository
                    .promiseOfCommandStatus(pluginAction.plugin.path, pluginStatus.action.command)
                    .then(commandStatusCode => this._buildReport(pluginAction, pluginStatus, commandStatusCode));
            })
            .catch(e => logError(e));
    },

    _buildReport(pluginAction, pluginStatus, commandStatusCode) {
        const actionLabel = pluginAction.actionLabel(),
            reportPrefix = `${actionLabel} of '${pluginAction.pluginLabel()}'`;

        let report;
        if (pluginAction.isPluginUnknown()) {
            report = `✗ ${reportPrefix} fail: plugin name unknown`;
        } else if (pluginAction.isStatus()) {
            report = `✓ ${reportPrefix} ${(pluginStatus.isPluginEnable()) ? "enabled" : "disabled"}`;
        } else if (this._isAlreadyApplied(pluginAction, pluginStatus)) {
            report = `✓ ${reportPrefix} already done`;
        } else if (pluginStatus.isMalicious && !pluginAction.forced) {
            report = `✗ ${reportPrefix} aborted: the plugin is trying to ` +
                `run the command '${pluginStatus.maliciousPart}' ` +
                `which might ${pluginStatus.maliciousDescription}. Use -f option to force the execution.`;
        } else if (commandStatusCode === 0) {
            report = `✓ ${reportPrefix} (${pluginStatus.action.label}) successfully completed`;
        } else {
            report = `✗ ${reportPrefix} (${pluginStatus.action.label}) failed`;
        }

        return report;
    },

    _isCommandRequired(pluginAction, pluginStatus) {
        const isAlreadyApplied = this._isAlreadyApplied(pluginAction, pluginStatus);
        return !isAlreadyApplied && pluginAction.isCommand() && (!pluginStatus.isMalicious || pluginAction.forced);
    },

    _isAlreadyApplied(pluginAction, pluginStatus) {
        switch (pluginAction.option.name) {
        case FedyOption.ADD.name:
            return pluginStatus.code === 0;
        case FedyOption.REMOVE.name:
            return pluginStatus.code !== 0;
        default:
            return false;
        }
    },

    _printReports(reports) {
        print();
        print("-------");
        reports.forEach(report => {
            print(report);
        });
    }

});

const concat = (x, y) => x.concat(y),
    flatMap = (f, xs) => xs.map(f).reduce(concat, []);
Array.prototype.flatMap = function(f) {
    return flatMap(f, this);
};

