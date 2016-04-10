#!/usr/bin/env bash

if type "brew" > /dev/null 2>&1; then

  brew update
  brew upgrade --all

  brew tap homebrew/dupes

  brew install gnu-sed --default-names
  brew install wget --with-iri

  brewlist=(
    coreutils
    homebrew/dupes/grep
    homebrew/dupes/openssh
    ack
    emacs
    git
    libxml2
    homebrew/python/matplotlib-basemap
    mysql
    postgresql
    pyenv
    pyenv-virtualenv
    sqlite
    vim
  )
  #additional stuff removed to save time
  # brew install imagemagick --with-webp

  for brewitem in "${brewlist[@]}"; do
    brew install "$brewitem";
  done
fi
