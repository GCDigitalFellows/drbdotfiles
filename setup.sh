#!/usr/bin/env bash

# Helper functions
info() {
  printf "\r  [ \033[00;34m..\033[0m ] %s\n" "$1"
}

user() {
  printf "\r  [ \033[0;33m??\033[0m ] %s\n" "$1"
}

success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

fail() {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n" "$1"
  echo ''
  exit
}

section() {
  info "............$1........."
}

e_ask() {
    printf "\n%s\n" "$1"
    printf "(y/N): "
}

is_confirmed() {
  result=$1
  read -rs -k 1 ans
  case "${ans}" in
    y|Y|$'\n')
      printf "Yes\n"
      (( result=1 ))
      return 1
      ;;
    *)  # This is the default
      printf "No\n"
      (( result=0 ))
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

info "*********************"
info "*    Here we go!    *"
info "*********************"

# Set up directories
DOTDIR="$HOME/.dotfiles"

# Install homebrew if it's not already installed
if ! type "brew" > /dev/null 2>&1; then
  info 'Installing Homebrew'
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi

# Install git before we continue
if ! type "git" > /dev/null 2&1; then
  brew update
  brew install git
fi
# Install homebrew cask if it's not already
if ! type "brew-cask" > /dev/null 2&1; then
  brew install caskroom/cask/brew-cask
fi

# clone the dotfiles
if [[ ! -d $DOTDIR ]]; then
  info "Cloning dotfiles to $DOTDIR"
  git clone https://github.com/gcdigitalfellows/drbdotfiles.git "$DOTDIR"
fi
cd "$DOTDIR" || exit

e_ask "Run all scripts without prompts?"
is_confirmed DOALL

if [ "$DOALL" -eq 0 ]; then
  if [[ $(uname) == 'Darwin' ]]; then
    e_ask "Install command line tools?"
    is_confirmed hb
  fi
  e_ask "Install Python pips?"
  is_confirmed pi
  e_ask "Symlink dotfiles?"
  is_confirmed lns
fi #[ $DOALL -eq 1 ]

if [[ $(uname) == 'Darwin' ]]; then
  if [ "$DOALL" -eq 1 ] || [ "$hb" -eq 1 ]; then
    section "Homebrew"
    info "Setting user permissions on /usr/local"
    sudo chown -R "$USER:admin" /usr/local
 
    source 'etc/brews.sh'
    source 'etc/cask.sh'
    pyenv install 2.7.11
    pyenv install 3.5.1
    pyenv anaconda3-2.4.0
    pyenv rehash
    pyenv global 3.5.1 2.7.11 anaconda3-2.4.0
  fi
fi

if [ "$DOALL" -eq 1 ] || [ "$pi" -eq 1 ]; then
  section "Python and Pips"
  source 'etc/pip.sh'
fi

if [ "$DOALL" -eq 1 ] || [ "$lns" -eq 1 ]; then
  section "Symlinking dotfiles"
  overwrite_all=false
  backup_all=false
  skip_all=false

  for src in $(find -H "$DOTDIR/home" -type f)
  do
    dst="$HOME/.$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done

  success "Dotfiles successfully symlinked to your home directory"

fi

success "Finished running all of the scripts."
success "You should probably restart your computer now."
