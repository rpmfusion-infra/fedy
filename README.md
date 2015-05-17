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
* `ozon-repos`

### Installation

Fedy can be installed with our [script](http://satya164.github.io/fedy/fedy-installer) which automatically sets up the repos and dependencies.

### Usage

After installation, search for `Fedy` in the menu/overview or type `fedy` in the terminal.

### Source code

You can get the latest source code from the [github page](http://github.com/satya164/fedy).

`git clone git@github.com:satya164/fedy.git`

### Bugs and feature requests

Please submit bugs and feature requests [here](http://github.com/satya164/fedy/issues). Pull requests are always welcome.
