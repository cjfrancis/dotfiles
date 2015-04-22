#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

function info () {
  printf '  [ \033[00;34m..\033[0m ] %s\n' "$1"
}

function user () {
  printf '\r  [ \033[0;33m?\033[0m ] %s ' "$1"
}

function success () {
  printf '\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n' "$1"
}

function warn () {
  printf '\r\033[2K  [\033[0;33mWARN\033[0m] %s\n' "$1"
}

function fail () {
  printf '\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n\n' "$1"
  exit 1
}

readonly OS="$(uname -s)"

info 'Starting bootstrap...'

# Git is required for the rest of the bootstrap script.
if [[ -r install/git ]]; then
  info 'Installing git...'
  if source install/git; then
    success 'Installed git'
  else
    fail 'Git is not installed'
  fi
fi

# Update the dotfiles repo.
info 'Pulling updates...'
if git pull origin master; then
  success 'Bootstrap updated'
else
  warn 'Could not update bootstrap'
fi

info 'Installing dependencies...'
if [[ "${OS}" == Darwin ]]; then
  if [[ -r install/osx ]]; then
    if source install/osx; then
      success 'Installed OS X dependencies'
    else
      fail 'Error installing dependencies'
    fi
  fi
fi

info 'Linking dotfiles...'
if stow --target="${HOME}" bash curl git login py zsh; then
  success 'Dotfiles linked'
else
  fail 'Error linking dotfiles'
fi

if [[ "${OS}" == Darwin ]]; then
  info 'Installing additional OS X utilities...'
  for file in osx/*; do
    info "${file}"
    if source "${file}"; then
      success "${file}"
    else
      warn "${file}"
    fi
  done
  success 'OS X utilities installed'
fi

success 'Bootstrap complete'
