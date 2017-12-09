#!/usr/bin/env bash

############################ BASIC SETUP TOOLS
msg() {
    printf '%b\n' "$1" >&2
}

variable_set() {
    if [ -z "$1" ]; then
        error "You must have your HOME environmental variable set to continue."
    fi
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}


############################ SETUP FUNCTIONS
create_symlinks() {
    local source_path="$1"
    local target_path="$2"

    lnif "$source_path/.vimrc"         "$target_path/.vimrc"
    ret="$?"
    success "Setting up vim symlinks."
}

program_must_exist() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value
    if [ "$ret" -ne 0 ]; then
        error "You must have '$1' installed to continue."
        return 1
    fi

    return 0
}

############################ MAIN()
variable_set "$HOME"
program_must_exist "git"
command -v 'vim -v'
program_must_exist "vim"
