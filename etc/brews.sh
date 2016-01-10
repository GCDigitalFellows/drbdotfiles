#!/usr/bin/env bash

if type "brew" > /dev/null 2>&1; then

  brew update
  brew upgrade --all

  brew tap homebrew/dupes
  brew tap homebrew/versions

  brew install gnu-sed --default-names
  brew install imagemagick --with-webp
  brew install wget --with-iri

  brewlist=( \
    coreutils \
    homebrew/dupes/grep \
    homebrew/dupes/openssh \
    ack \
    emacs \
    git \
    libxml2 \
    homebrew/python/matplotlib-basemap \
    mysql \
    postgresql \
    pyenv \
    pyenv-virtualenv \
    sqlite \
    vim \
  )
  for brewitem in $brewlist; do
    brew install "$brewitem";
  done
fi
