// Handles command execution, sequential queueing, and malicious pattern scanning

import GLib from 'gi://GLib';
import { readFileContent } from './utils.js';

export class CommandRunner {
    constructor(appDir, config) {
        this.appDir = appDir;
        this.config = config;
        this._queue = [];
    }

    get queueLength() {
        return this._queue.length;
    }

    // Spawn a command asynchronously
    execute(workingDir, command, callback = () => {}) {
        let ok, argv;
        try {
            [ok, argv] = GLib.shell_parse_argv(command);
        } catch {
            callback(null, 1);
            return;
        }

        if (!ok) {
            callback(null, 1);
            return;
        }

        let envp = GLib.get_environ();
        const path = GLib.environ_getenv(envp, 'PATH');
        // Include app bin/ and plugin working dir so scripts like status.sh are found
        envp = GLib.environ_setenv(envp, 'PATH', `${path}:${this.appDir}/bin:${workingDir}`, true);

        let pid;
        try {
            [ok, pid] = GLib.spawn_async(
                workingDir, argv, envp,
                GLib.SpawnFlags.SEARCH_PATH_FROM_ENVP | GLib.SpawnFlags.DO_NOT_REAP_CHILD,
                null
            );
        } catch (e) {
            console.log(`Failed to spawn: ${e.message}`);
            callback(null, 1, e);
            return;
        }

        if (!ok) {
            callback(pid, 1);
            return;
        }

        if (typeof pid === 'number') {
            GLib.child_watch_add(GLib.PRIORITY_DEFAULT, pid, (...args) => {
                GLib.spawn_close_pid(pid);
                callback(...args);
            });
        }
    }

    // Add command to sequential queue
    enqueue(workingDir, command, callback = () => {}) {
        this._queue.push([workingDir, command, callback]);
        if (this._queue.length === 1) this._processQueue();
    }

    _processQueue() {
        if (!this._queue.length) return;
        const [wd, cmd, cb] = this._queue[0];

        this.execute(wd, cmd, (...args) => {
            this._queue.shift();
            cb(...args);
            this._processQueue();
        });
    }

    // Determine which action script applies (exec or undo) based on status check
    getPluginStatus(plugin, callback) {
        if (typeof callback !== 'function') return;
        const { scripts } = plugin;

        if (scripts?.status?.command) {
            this.execute(plugin.path, scripts.status.command, (_pid, status) => {
                callback(status === 0 ? scripts.undo : scripts.exec, status);
            });
        } else {
            callback(scripts.exec, 1);
        }
    }

    // Scan command for malicious patterns, returns [isMalicious, command, description]
    scanMalicious(pluginPath, command) {
        const patterns = this.config.malicious || [];
        let parts = command.split(';');
        parts.push(command);

        // Also scan referenced shell scripts
        const scriptRefs = command.match(/\S+\.(sh|bash)/);
        if (Array.isArray(scriptRefs)) {
            for (const script of scriptRefs) {
                const content = readFileContent(`${pluginPath}/${script}`);
                if (content) parts = parts.concat(content.split(/\n/));
            }
        }

        // Deduplicate, strip comments and blanks
        const unique = [...new Set(
            parts.map(p => p.trim()).filter(p => /^[^#]/.test(p) && p.length > 1)
        )];

        for (const item of patterns) {
            if (!Array.isArray(item.variations)) continue;
            for (const pat of item.variations) {
                let regex;
                try { regex = new RegExp(pat); } catch { continue; }

                for (const part of unique) {
                    if (regex.test(part)) return [true, part, item.description];
                }
            }
        }

        return [false, null, null];
    }
}
