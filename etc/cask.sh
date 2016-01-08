#!/usr/bin/env bash

#
# Install gui apps (formerly via homebrew-cask, now integrated into homebrew)

# Make sure we’re using the latest Homebrew
brew update

# Install native apps with cask
casklist=(
  anaconda
  atom
  avast
  brackets
  cyberduck
  diffmerge
  firefox
  github-desktop
  google-chrome
  iterm2
  keka
  libreoffice
  mapbox-studio
  qgis
  r
  sequel-pro
  sourcetree
  sqlitebrowser
  textmate
  tilemill
  virtualbox
  vlc
  zotero
)
for caskitem in $casklist; do
  brew cask install $caskitem;
done

# Remove outdated versions from the cellar
brew cleanup
