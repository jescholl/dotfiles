#!/bin/bash

# Only install if we're on linux
if [ "$(uname -s)" != "Linux" ]; then
  exit 0
fi

source "$DOTFILES_ROOT/bootstrap/functions"
log_info 'updating apt'

sudo apt update > /dev/null 2>&1

# Install packages
log_info 'installing packages'
packages="awscli grc ipcalc dhcping wget nmap mtr httpie jq autojump zsh xsel silversearcher-ag"
for pkg in $packages; do
  if dpkg -s "$pkg" > /dev/null 2>&1; then
    log_success "Already installed $pkg"
    continue
  fi

  # shellcheck disable=SC2024
  if sudo apt install "$pkg" > "/tmp/install_$pkg.log" 2>&1; then
    log_success "Installed $pkg"
  else
    log_fail "Unable to install $pkg"
  fi
done

exit 0
