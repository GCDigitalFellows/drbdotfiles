#!/usr/bin/env bash

if type "brew" > /dev/null 2>&1; then

  brew update
  brew upgrade --all

  brew tap homebrew/dupes

  brew install gnu-sed --with-default-names
  brew install wget --with-iri

  brewlist=(
    coreutils
    homebrew/dupes/grep
    homebrew/dupes/openssh
    ack
    emacs
    git
    libxml2
    mysql
    postgresql
    pyenv
    pyenv-virtualenv
    rbenv
    sqlite
    vim
  )
  #additional stuff removed to save time
  # imagemagick --with-webp
  # homebrew/python/matplotlib-basemap

  for brewitem in "${brewlist[@]}"; do
    brew install "$brewitem";
  done
fi
