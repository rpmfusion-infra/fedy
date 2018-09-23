const GLib = imports.gi.GLib,
    Lang = imports.lang;

var Option = new Lang.Class({
    Name: "Option",

    _init(name, optionArg, desc, placeholder, isAction) {
        this.name = name;
        this.shortName = this.name.charCodeAt(0);
        this.optionArg = optionArg;
        this.desc = desc;
        this.placeholder = placeholder;
        this.isAction = isAction;
    },

    registerIn(application) {
        application.add_main_option(
            this.name, this.shortName, GLib.OptionFlags.IN_MAIN, this.optionArg, this.desc, this.placeholder);
    },

    in(options) {
        return options.contains(this.name);
    },

    match(optionName) {
        return this.name === optionName;
    },

    parameters(options) {
        return options.lookup_value(this.name, null).get_strv();
    }
});
