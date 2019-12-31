#!/bin/bash

# Only install homebrew if we're on a Mac
if [ "$(uname -s)" != "Darwin" ]; then
  exit 0
fi

#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if ! command -v brew > /dev/null; then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

# Install homebrew packages

installed_packages="$(brew info --installed --json | jq .[].name)"

brew_packages="awscli grc ipcalc tcping dhcping csshx gnu-tar wget nmap rbenv ruby-build mtr httpie exercism jq ag autojump npm git-standup shellcheck vim"
for pkg in $brew_packages; do
  if [[ "$installed_packages" =~ \"$pkg\" ]]; then
    continue
  fi
  brew install "$pkg"
done
