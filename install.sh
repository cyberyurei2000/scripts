#!/bin/sh

# Copyright (c) cyberyurei2000 2024-2025
# Released under the BSD 3-Clause License
# https://opensource.org/license/bsd-3-clause

DIR=$(pwd)

if [ "$XDG_DATA_HOME" = "" ]; then
    XDG_DATA_HOME="$HOME/.local/share"
fi

setup_scripts() {
    if [ ! -d "$HOME/.local/bin" ]; then
        mkdir -p "$HOME/.local/bin"
    fi
    BIN_PATH="$HOME/.local/bin"

    cp -a "./bin/unix/." "$BIN_PATH/"
}

setup_dolphin_services() {
    if [ ! -d "$XDG_DATA_HOME/kio/servicemenus" ]; then
        mkdir -p "$XDG_DATA_HOME/kio/servicemenus"
    fi
    SERVICES_PATH="$XDG_DATA_HOME/kio/servicemenus"

    cp -a "./services/." "$SERVICES_PATH/"
}

setup_scripts
setup_dolphin_services
