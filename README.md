# GC Digital Research Bootcamp Dotfiles

## Quickstart

Open a Terminal window (Applications > Terminal.app) and paste the following
command in a single line, then hit Enter:

```bash
bash -c "$(curl -L https://raw.githubusercontent.com/GCDigitalFellows/drbdotfiles/master/setup.sh)"
```

Follow the prompts and you should be golden!

## Something went wrong

1. Try manually installing [homebrew](http://brew.sh/).

  ```bash
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  ```

2. Install git and clone this repo

  ```bash
  brew install git
  git clone https://github.com/GCDigitalFellows/drbdotfiles ~/.dotfiles
  ```

3. Run the installation script

  ```bash
  cd ~/.dotfiles
  source setup.sh
  ```

# What’s Installed with this?

##Basics

* OS X Command Line Tools
* homebrew
* homebrew cask
* python 2.7.11, 3.5.1, anaconda3

##Homebrew stuff

* coreutils: gnu versions of all the good stuff
* updated versions of grep/sed/wget/ack/openssh
* emacs: editor
* vim: [better] editor
* git: version control
* libxml2: xml parsing, prereq for lots of software
* matplotlib-basemap: basemap for python (needs to be built)
* mysql: updated version of database software
* postgresql: another database option
* sqlite: yet another database option (better for local apps...)
* pyenv: python environment manager and installer
* pyenv-virtualenv: for using virtualenv with pyenv

##~~Gui Apps (casks)~~ (removed in favor of installing via Remote Desktop)

* ~~emacs-cocoa: gui versions of emacs~~
* ~~atom: open source text editor~~
* ~~avast: anti-virus/malware~~
* ~~cyberduck: ftp~~
* ~~diffmerge: gui diff tool~~
* ~~firefox/chrome: browsers~~
* ~~gimp: image editor~~
* ~~github: gui github client~~
* ~~inkscape: vector graphics editor~~
* ~~iterm2: better terminal editor~~
* ~~keka: better gui archive utility~~
* ~~libreoffice: free office suite~~
* ~~macvim: gui editor~~
* ~~mapbox-studio: gis suite~~
* ~~qgis: gis suite~~
* ~~r: statistical software~~
* ~~sequel-pro: gui database management~~
* ~~sourcetree: gui svn client~~
* ~~sqlitebrowser: gui sqlite db client~~
* ~~textmate: another editor~~
* ~~tilemill: gui tool for editing map tiles~~
* ~~virtualbox: virtual machine engine~~
* ~~zotero: reference management software~~

##Python

* cartopy: cartography with matplotlib
* jupyter: ipython notebooks
* matplotlib: mapping lib
* nltk: natural language toolkit
* numpy: base library for scientific computing
* pandas: data manipulation
* pillow: images
* pyshp: shapefiles
* scipy: “science” tools
* shapely: shape manipulation
* shapy: network emulation
* sklearn: machine learning
* virtualenv: virtual environments for isolating dependencies
