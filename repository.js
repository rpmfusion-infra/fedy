const Lang = imports.lang;

var PluginStatus = new Lang.Class({
    Name: "PluginStatus",

    _init(code, action, isMalicious, maliciousPart, maliciousDescription) {
        this.code = code;
        this.action = action;
        this.isMalicious = isMalicious;
        this.maliciousPart = maliciousPart;
        this.maliciousDescription = maliciousDescription;
    },

    isPluginEnable() {
        return this.code === 0;
    }
});

var Plugin = new Lang.Class({
    Name: "Plugin",

    _init(name, plugin) {
        this.name = name;
        this.label = plugin.label;
        this.description = plugin.description;
        this.license = plugin.license;
        this.category = plugin.category;
        this.path = plugin.path;
        this.icon = plugin.icon;
        if (typeof plugin.scripts !== "undefined") {
            this.scripts = {
                exec: plugin.scripts.exec,
                undo: plugin.scripts.undo,
                status: plugin.scripts.status
            };
        }
    }
});

var PluginRepository = new Lang.Class({
    Name: "PluginRepository",

    _init(fedy) {
        this.fedy = fedy;
        this.fedy._loadConfig();
        this.fedy._loadPlugins();

        this.plugins = {};
        for (let category in this.fedy._plugins) {
            if (this.fedy._plugins.hasOwnProperty(category)) {
                this._toPlugin(this.fedy._plugins[category]);
                this.plugins = Object.assign({}, this.plugins, this.fedy._plugins[category]);
            }
        }
    },

    listCategories() {
        return Object.keys(this.fedy._plugins).sort();
    },

    listByCategory(category) {
        return Object.values(this.fedy._plugins[category]);
    },

    getByName(pluginName) {
        return this.plugins.hasOwnProperty(pluginName) ? this.plugins[pluginName] : {name: pluginName};
    },

    promiseOfPluginStatus(plugin) {
        return new Promise((resolve) => {
            if (typeof plugin.label === "undefined") {
                resolve(new PluginStatus());
            }

            this.fedy._getPluginStatus(plugin, (action, statusCode) => {
                const [ isMalicious, maliciousPart, description ] = this.fedy._scanMaliciousCommand(plugin, action.command),
                    pluginStatus = new PluginStatus(statusCode, action, isMalicious, maliciousPart, description);
                resolve(pluginStatus);
            });
        });
    },

    promiseOfCommandStatus(path, command) {
        return new Promise((resolve) => {
            this.fedy._queueCommand(path, command, (pid, commandStatusCode) => {
                resolve(commandStatusCode);
            });
        });
    },

    _toPlugin(plugins) {
        Object.keys(plugins)
            .forEach(pluginName => {
                plugins[pluginName] = new Plugin(pluginName, plugins[pluginName]);
            });
    }
});

