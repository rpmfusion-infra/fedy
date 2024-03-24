#!/bin/bash

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

version=$(get_latest_release "Foundry376/Mailspring")

dnf install -y https://github.com/Foundry376/Mailspring/releases/download/$version/mailspring-$version-0.1.x86_64.rpm
