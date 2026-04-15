// CLI option definition - wraps GLib option registration and lookup

import GLib from 'gi://GLib';

export class Option {
    constructor(name, optionArg, desc, placeholder, isAction) {
        this.name = name;
        this.shortName = name.charCodeAt(0);
        this.optionArg = optionArg;
        this.desc = desc;
        this.placeholder = placeholder;
        this.isAction = isAction;
    }

    // Register this option on a GtkApplication
    registerIn(application) {
        application.add_main_option(
            this.name, this.shortName, GLib.OptionFlags.IN_MAIN,
            this.optionArg, this.desc, this.placeholder
        );
    }

    in(options) {
        return options.contains(this.name);
    }

    match(optionName) {
        return this.name === optionName;
    }

    parameters(options) {
        return options.lookup_value(this.name, null).get_strv();
    }
}
