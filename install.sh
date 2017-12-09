#!/usr/bin/env bash

############################  SETUP PARAMETERS
[ -z "$APP_PATH" ] && APP_PATH="$HOME/.spf13-vim-3"
[ -z "$BUNDLE_PATH" ] && BUNDLE_PATH="$HOME/.vim/bundle"

[ -z "$OGEN_PATH" ] && OGEN_PATH="$HOME/.vim/autoload/pathogen.vim"
[ -z "$OGEN_URI" ] && OGEN_URI="https://tpo.pe/pathogen.vim"

[ -z "$TAGLIST_URI" ] && TAGLIST_URI="https://github.com/prefree/taglist.git"
[ -z "$TAGLIST_PATH" ] && TAGLIST_PATH="$HOME/.vim/bundle/taglist"

[ -z "$CTRLP_URI" ] && CTRLP_URI="https://github.com/kien/ctrlp.vim.git"
[ -z "$CTRLP_PATH" ] && CTRLP_PATH="$HOME/.vim/bundle/ctrlp.vim"

[ -z "$NERDTREE_URI" ] && NERDTREE_URI="https://github.com/scrooloose/nerdtree.git"
[ -z "$NERDTREE_PATH" ] && NERDTREE_PATH="$HOME/.vim/bundle/nerdtree"

[ -z "$VUNDLE_URI" ] && VUNDLE_URI="https://github.com/VundleVim/Vundle.vim.git"
[ -z "$VUNDLE_PATH" ] && VUNDLE_PATH="$HOME/.vim/bundle/Vundle.vim"

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

sync_plugin() {
    local repo_path="$1"
    local repo_uri="$2"
    local repo_branch="$3"
    local repo_name="$4"
	
    msg "Trying to install $repo_name"

    if [ ! -e "$repo_path" ]; then
        git clone -b "$repo_branch" "$repo_uri" "$repo_path"
        ret="$?"
        success "Successfully cloned $repo_name."
    else
        cd "$repo_path" && git pull origin "$repo_branch"
        ret="$?"
        success "Successfully updated $repo_name"
    fi

}
install_pathogen() {
	msg "try to install pathogen ..."

	if [ ! -e "$2" ]; then
		mkdir -p ~/.vim/autoload ~/.vim/bundle &&curl -LSso "$2" "$1"
		reg="$?"
		msg "Install pathogen success"
	else
		msg "already has pathogen."
	fi
}

checkout_bundle() {
	if [ ! -e "$BUNDLE_PATH" ]; then
	    mkdir -p "$BUNDLE_PATH"
		success "Create $BUNDLE_PATH success"
	else
		msg "already has $BUNDLE_PATH"
	fi
}
############################ MAIN()
variable_set "$HOME"
program_must_exist "git"
program_must_exist "vim"
program_must_exist "curl"

checkout_bundle

install_pathogen $OGEN_URI $OGEN_PATH

sync_plugin       "$TAGLIST_PATH" \
                  "$TAGLIST_URI" \
                  "master" \
                  "taglist"

sync_plugin       "$NERDTREE_PATH" \
                  "$NERDTREE_URI" \
                  "master" \
                  "nerdtree"

sync_plugin       "$CTRLP_PATH" \
                  "$CTRLP_URI" \
                  "master" \
                  "ctrlp"

sync_plugin       "$VUNDLE_PATH" \
                  "$VUNDLE_URI" \
                  "master" \
                  "vundle"

