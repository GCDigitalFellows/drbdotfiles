#!/usr/bin/env bash

#
# Install gui apps (formerly via homebrew-cask, now integrated into homebrew)

# Make sure we’re using the latest Homebrew
brew update

# Install native apps with cask
casklist=(
  aquamacs
  atom
  avast
  brackets
  cyberduck
  diffmerge
  emacs
  firefox
  gimp
  github-desktop
  google-chrome
  inkscape
  iterm2
  keka
  libreoffice
  macvim
  mapbox-studio
  qgis
  r
  sequel-pro
  sourcetree
  sqlitebrowser
  textmate
  tilemill
  virtualbox
  zotero
)
for caskitem in "${casklist[@]}"; do
  brew cask install --appdir="/Applications" "$caskitem"
done

# Remove outdated versions from the cellar
brew cleanup
