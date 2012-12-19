### Introduction

Fedora Utils is a post installation script for Fedora. It lets you install codecs and additional software, fix problems, tweak and cleanup your system, view system information and much more with just few clicks.

### License

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see [gnu.org/licenses](http://www.gnu.org/licenses/).

Copyright (C) [Satyajit Sahoo](mailto:satyajit.happy@gmail.com)

### Documentation

Documentation is available online. Please visit the [wiki](http://github.com/satya164/fedorautils/wiki).

### How to install

To install the latest stable version of Fedora Utils in your system, first add the repo,

`su -c "curl http://download.opensuse.org/repositories/home:/satya164:/fedorautils/Fedora_17/home:satya164:fedorautils.repo -o /etc/yum.repos.d/fedorautils.repo && yum install fedorautils"`

Then install Fedora Utils using the following commands,

`su -c "yum install fedorautils"`

### How to use

After installation, launch Fedora Utils from `Applications > System Tools` or type `fedorautils` in the terminal.

### Getting the source

You can get the latest source code from the [github page](http://github.com/satya164/fedorautils).

`git clone git@github.com:satya164/fedorautils.git`

### Bugs and feature requests

Please submit bugs and feature requests [here](http://github.com/satya164/fedorautils/issues).
