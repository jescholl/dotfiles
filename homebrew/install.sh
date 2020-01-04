#!/bin/bash

# Only install homebrew if we're on a Mac
if [ "$(uname -s)" != "Darwin" ]; then
  exit 0
fi

source "$DOTFILES_ROOT/bootstrap/functions"

#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if ! command -v brew > /dev/null; then
  log_info "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

# Install homebrew packages

installed_packages="$(brew info --installed --json | jq .[].name)"

brew_packages="awscli grc ipcalc tcping dhcping csshx gnu-tar wget nmap rbenv ruby-build mtr httpie exercism jq ag autojump npm git-standup shellcheck vim"
for pkg in $brew_packages; do
  log_info "Installing $pkg"
  if [[ "$installed_packages" =~ \"$pkg\" ]]; then
    log_success "  Already installed"
    continue
  fi
  if brew install "$pkg"; then
    log_success "  Already installed"
  else
    log_failure "  Unable to install"
  fi
done
