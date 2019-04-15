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
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

# Install homebrew packages

# autocomplete for many tools

brew_packages="awscli grc ipcalc tcpint dhcping csshx gnu-tar wget nmap rbenv ruby-build mtr httpie exercism jq ag autojump"
for pkg in $brew_packages; do
  brew install $pkg
done

exit 0
