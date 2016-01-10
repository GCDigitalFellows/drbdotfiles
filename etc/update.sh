#!/usr/bin/env bash

#
# Update everything
#

if [[ $(uname) == darwin* ]]; then
    echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> System updates <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
    sudo softwareupdate -i -a
    echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update Homebrew <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
    brew update
    echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update Brew Packages <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
    brew upgrade --all
    echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Cleanup Outdated Brew Packages <<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
    brew cleanup
    # echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update Brew Casks <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
    # brew-cask-upgrade
    # echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Cleanup Outdated Casks <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
    # $DOTDIR/bin/brew-cask-cleanup
elif type "apt-get" 2>/dev/null; then
    echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update APT package list <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
    sudo apt-get update
    echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update APT Packages <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
    sudo apt-get upgrade
fi

# echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update N Version Manager <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
# n latest
# echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update NPM Package Manager <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
# npm install npm@latest -g
# echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update Node Packages <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
# npm update -g
# echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update Gem Package Manager <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
# gem update --system
# echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update Gem Packages <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
# gem update
# if ! which 'brew' > /dev/null; then
#     echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update rbenv <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
#     if [[ -d "$HOME/.rbenv" ]]; then
#         cd $HOME/.rbenv
#         git pull
#     fi
#     if [[ -d "$HOME/.rbenv/plugins/ruby-build" ]]; then
#         cd $HOME/.rbenv/plugins/ruby-build
#         git pull
#     fi
# fi
echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update PIP <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
pip install -U pip
echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update PIP Packages <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
source $DOTDIR/etc/pip.sh
# echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update Oh My ZSH <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
# upgrade_oh_my_zsh
# echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update Zgen <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
# zgen selfupdate
# echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update Zgen Packages <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
# zgen update
# echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Reload Zsh <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
# exec $SHELL
#
# echo "${bg[magenta]}${fg[yellow]}>>>>>>>>>>>>>>>>>>>>> Update Vim <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${reset_color}"
# vim +PlugUpdate +PlugClean! +q +q
