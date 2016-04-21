### Introduction

Fedy lets you install multimedia codecs and additional software that Fedora [doesn't want to ship](http://fedoraproject.org/wiki/Forbidden_items?rd=ForbiddenItems), like mp3 support, Adobe Flash, Oracle Java etc., and much more with just a few clicks.

### License

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see [gnu.org/licenses](http://www.gnu.org/licenses/).

Copyright (C) [Satyajit Sahoo](mailto:satyajit.happy@gmail.com)

### Dependencies

Fedy relies on `GTK+3` and `GJS` for it's UI layer.

The included plugins rely on the following packages,
* `dnf`
* `dnf-plugins-core`
* `wget`
* `rpmfusion-free-release`
* `rpmfusion-nonfree-release`
* `folkswithhats-release`

### Installation

Fedy can be installed with our [script](http://folkswithhats.org/fedy-installer) which automatically sets up the repos and dependencies.

### Usage

After installation, search for `Fedy` in the menu/overview or type `fedy` in the terminal.

### Plugin structure

Plugins can be placed under `~/.local/share/fedy/plugins/`, or the system plugins directory.

Each plugin is a directory with the suffix `.plugin`, which consist of a JSON formatted metadata file. The metadata file contains information about the plugin and describes how `Fedy` should run the tasks.

The plugins can run any command or scripts (`bash`, `python` etc.). In addtion to the system commands, `Fedy` provides an additional command, `run-as-root` to allow running commands (e.g.- `run-as-root touch /some/file/somewhere`) or scripts (e.g.- `run-as-root -s do-stuff.sh`) as root.

Have a look at the existing plugins to know more about how to write plugins for `Fedy`.

### Source code

You can get the latest source code from the [github page](https://github.com/folkswithhats/fedy).

`git clone https://github.com/folkswithhats/fedy`

### Bugs and feature requests

Please submit bugs and feature requests [here](https://github.com/folkswithhats/fedy/issues). Pull requests are always welcome.
