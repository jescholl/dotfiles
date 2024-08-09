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
  if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /tmp/install-homebrew.log 2>&1; then
    log_fail "Unable to install homebrew"
  fi
fi

log_info "Updating brew"
if ! brew update > /tmp/brew-update.log 2>&1; then
  log_fail "Error while updating brew"
fi


# Install homebrew packages

installed_packages="$(brew info --installed --json | jq .[].name)"

brew_packages="awscli grc ipcalc tcping dhcping csshx gnu-tar wget nmap mtr httpie exercism jq the_silver_searcher autojump node git-standup shellcheck tflint vim tfenv coreutils eza bat gnupg hcl2json"
log_info "Installing packages"
for pkg in $brew_packages; do
  if [[ "$installed_packages" =~ \"$pkg\" ]]; then
    log_success "Already installed $pkg"
    continue
  fi

  if brew install "$pkg" > "/tmp/install-$pkg.log" 2>&1; then
    log_success "Installed $pkg"
  else
    log_fail "Unable to install $pkg"
  fi
done

brew install --cask rectangle
