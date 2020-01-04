#!/bin/bash
source "$DOTFILES_ROOT/bootstrap/functions"
if ! command -v brew; then
  log_info "Homebrew not installed, skipping"
elif ! python --version | grep "Python 3" > /dev/null ; then
  log_info "Installing python"

  if brew install python; then
    log_success "Python successfully installed"
  else
    log_fail "Unable to install python"
  fi
else
  log_success "Python3 already instaled"
fi

# FIXME: make sure the pip and python links point to python3

pip install --user pipenv
