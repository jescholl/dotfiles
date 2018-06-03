#!/bin/sh

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
brew install grc

brew install ipcalc
brew install tcping
brew install dhcping
brew install csshx
brew install gnu-tar
brew install wget
brew install nmap
brew install rbenv
brew install ruby-build
brew install mtr
brew install httpie
brew install exercism

exit 0
