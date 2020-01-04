#!/bin/bash

# Only install if we're on linux
if [ "$(uname -s)" != "Linux" ]; then
  exit 0
fi

sudo apt update

# Install packages

# autocomplete for many tools

# FIXME: install ruby-build (and rbenv?) from git

packages="awscli grc ipcalc tcpint dhcping csshx gnu-tar wget nmap rbenv ruby-build mtr httpie exercism jq ag autojump zsh xsel silversearcher-ag"
for pkg in $packages; do
  sudo apt install $pkg
done

exit 0
