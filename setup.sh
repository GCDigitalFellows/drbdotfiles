#!/bin/bash

DOTDIR="$HOME/.dotfiles"
RBVERSION="2.3.0"
PY3VERSION="3.5.1"
PY2VERSION="2.7.11"
ANACONDAVERSION="anaconda3-2.5.0"

# helper functions
command_exists () {
  command -v "$1" &> /dev/null 2>&1
}

info() {
  printf "\r  [ \033[00;34m=>\033[0m ] %s\n" "$1"
}

user() {
  printf "\r  [ \033[0;33m??\033[0m ] %s" "$1"
}

success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

warn() {
  printf "\r  [ \033[00;33m!!\033[0m ] %s\n" "$1"
}

fail() {
  printf "\r\033[2K  [\033[0;31mXX\033[0m] %s\n" "$1"
  echo ''
  exit
}

section() {
  info ""
  info ""
  info "............ $1 ..........."
  info ""
}

e_ask() {
  user "$1 (y/N):"
}

is_confirmed() {
  local result=$1
  read -rs -n1 ans
  case "${ans}" in
    y|Y|$'\n')
      printf "Yes\n"
      (( $result=1 ))
      return 1
      ;;
    *)  # This is the default
      printf "No\n"
      (( $result=0 ))
      return 0
    esac
}

link_file() {
  src=$1
  dst=$2
  unset overwrite
  unset backup
  unset skip
  unset action

  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]; then
    if [[ "$overwrite_all" == "false" ]] && [[ "$backup_all" == "false" ]] && [[ "$skip_all" == "false" ]]; then
      currentSrc=$(readlink "$dst")
      if [[ "$currentSrc" == "$src" ]]; then
        skip=true;
      else
        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -r action
        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [[ "$overwrite" == "true" ]]; then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [[ "$backup" == "true" ]]; then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [[ "$skip" == "true" ]]; then
      success "skipped $src"
    fi
  fi

  if [[ "$skip" != "true" ]]; then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

# read initial newline
info 'GCDF Mac setup script. You may be prompted for your password. Hit a key to continue...'
read -r dummy
info "Here we go!"

section "Preliminary Software Checks"

# Set up directories
clt=$(xcode-select -p &>/dev/null)$?
info "Checking for XCode command line tools"
if [[ $clt -eq 2 ]]; then
  warn "The command line tools were not found. Attempting to install them..."
  curl -L https://raw.githubusercontent.com/GCDigitalFellows/drbdotfiles/master/etc/clt.sh | sh
else
  success "Command line tools already installed"
fi

# Install homebrew if it's not already installed
info "Checking for Homebrew"
if ! command_exists 'brew'; then
  warn "Homebrew not found. Attempting to install it..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  success "Homebrew is already installed"
fi

# Install git before we continue
info "Checking for Git"
if ! command_exists 'git'; then
  warn "Git (command line) not found. Attempting to install it using Homebrew..."
  brew update
  brew install git
else
  success "Git is already installed"
fi

# Install homebrew cask if it's not already
# This isn't the best way to test if it's installed, but it was the easiest
# thing that I could think of since the recent merger of cask into homebrew
# if [[ ! -d "/opt/homebrew-cask/Caskroom" ]]; then
#   brew install caskroom/cask/brew-cask
# fi

section "Setting up dotfiles repo"
# clone the dotfiles
pushd $(pwd)
if [[ ! -d $DOTDIR ]]; then
  info "Cloning dotfiles to your user directory"
  git clone https://github.com/gcdigitalfellows/drbdotfiles.git "$DOTDIR"
  cd "$DOTDIR" &>/dev/null
else
  warn "$DOTDIR exists. Attempting to update from repo"
  cd "$DOTDIR" &>/dev/null
  git pull
fi

e_ask "Run remainder of software scripts without prompts?"
is_confirmed DOALL

if [[ "$DOALL" -eq 0 ]]; then
  e_ask "Install Homebrew apps?"
  is_confirmed hb
  # e_ask "Install Homebrew cask apps?"
  # is_confirmed ca
  e_ask "Install Python and Pip/Anaconda packages?"
  is_confirmed pi
  e_ask "Install Ruby using rbenv?"
  is_confirmed rb
  e_ask "Symlink dotfiles?"
  is_confirmed lns
fi #[ $DOALL -eq 1 ]

if [[ "$DOALL" -eq 1 ]] || [[ "$hb" -eq 1 ]]; then
  section "Installing Homebrew Packages"
  # info "Setting user permissions on /usr/local"
  # sudo chown -R "$USER:admin" /usr/local
  source "./etc/brews.sh"
	success "Finished installing packages with Homebrew"
fi
# if [[ "$DOALL" -eq 1 ]] || [[ "$ca" -eq 1 ]]; then
#   section "Homebrew Cask"
#   source 'etc/cask.sh'
# fi

if [[ "$DOALL" -eq 1 ]] || [[ "$pi" -eq 1 ]]; then
  section "Python and Python Packages"
	info "Installing Python $PY2VERSION, $PY3VERSION, and anaconda using pyenv"
  pyenv install $PY3VERSION
  pyenv install $PY2VERSION
  pyenv install $ANACONDAVERSION
  pyenv global $PY3VERSION $PY2VERSION $ANACONDAVERSION
  source "$HOME/.bash_profile" # refresh the environment to get pyenv up and running
	info "Installing Python packages"
  source "$DOTDIR/etc/pip.sh"
	success "Finished installing Python packages"
fi

if [[ "$DOALL" -eq 1 ]] || [[ "$rb" -eq 1 ]]; then
  section "Rbenv and Ruby Gem Packages"
  info "Installing Ruby versions"
  source "$HOME/.bash_profile"
  rbenv install $rbversion
  success "Installed Ruby 2.3.0"
fi

if [[ "$DOALL" -eq 1 ]] || [[ "$lns" -eq 1 ]]; then
  section "Symlinking dotfiles"
  overwrite_all=false
  backup_all=false
  skip_all=false

  for src in $(find -H "$DOTDIR/home" -type f); do
    dst="$HOME/.$(basename "${src%}")"
    link_file "$src" "$dst"
  done
  success "Dotfiles successfully symlinked to your home directory"
fi

popd &>/dev/null

success "Finished running all of the installation scripts."
# e_ask "Would you like to create some shortcuts on the desktop?"
# is_confirmed sc
# if [[ "$sc" -eq 1 ]]; then
#   dst="$HOME/Desktop/"
#   ln -sf /Applications/Atom.app "$dst"
#   ln -sf /Applications/Cyberduck.app "$dst"
#   ln -sf /Applications/Firefox.app "$dst"
#   ln -sf /Applications/Google\ Chrome.app "$dst"
#   ln -sf /Applications/GitHub\ Desktop.app "$dst"
#   ln -sf /Applications/iTerm.app "$dst"
#   ln -sf /Applications/QGIS.app "$dst"
#   ln -sf /Applications/R.app "$dst"
# fi
warn "You should probably restart your computer now."
