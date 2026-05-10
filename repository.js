// Plugin data model and repository for CLI operations

export class PluginStatus {
    constructor(code, action, isMalicious, maliciousPart, maliciousDescription) {
        this.code = code;
        this.action = action;
        this.isMalicious = isMalicious;
        this.maliciousPart = maliciousPart;
        this.maliciousDescription = maliciousDescription;
    }

    isPluginEnable() {
        return this.code === 0;
    }
}

export class Plugin {
    constructor(name, raw) {
        this.name = name;
        this.label = raw.label;
        this.description = raw.description;
        this.license = raw.license;
        this.category = raw.category;
        this.path = raw.path;
        this.icon = raw.icon;

        if (raw.scripts) {
            this.scripts = {
                exec: raw.scripts.exec,
                undo: raw.scripts.undo,
                status: raw.scripts.status,
            };
        }
    }
}

// Provides plugin lookup and async status/command execution for CLI
export class PluginRepository {
    constructor(rawPlugins, commandRunner) {
        this.commandRunner = commandRunner;
        this._categorized = rawPlugins;

        // Build flat name -> Plugin map
        this.plugins = {};
        for (const category in rawPlugins) {
            for (const name in rawPlugins[category]) {
                this.plugins[name] = new Plugin(name, rawPlugins[category][name]);
            }
        }
    }

    listCategories() {
        return Object.keys(this._categorized).sort();
    }

    listByCategory(category) {
        return Object.keys(this._categorized[category]).map(name => this.plugins[name]);
    }

    getByName(name) {
        return this.plugins[name] || { name };
    }

    // Resolve plugin status asynchronously
    promiseOfPluginStatus(plugin) {
        return new Promise((resolve) => {
            if (typeof plugin.label === 'undefined') {
                resolve(new PluginStatus());
                return;
            }

            this.commandRunner.getPluginStatus(plugin, (action, statusCode) => {
                const [isMalicious, part, desc] = this.commandRunner.scanMalicious(
                    plugin.path, action.command
                );
                resolve(new PluginStatus(statusCode, action, isMalicious, part, desc));
            });
        });
    }

    // Run a command and resolve with its exit code
    promiseOfCommandStatus(path, command) {
        return new Promise((resolve) => {
            this.commandRunner.enqueue(path, command, (_pid, code) => resolve(code));
        });
    }
}
