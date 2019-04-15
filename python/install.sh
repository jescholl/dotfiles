#!/bin/bash
source $DOTFILES_SCRATCH/bootstrap/functions
if test ! $(which brew); then
  log_info "Homebrew not installed, skipping"
elif test ! $(python --version | grep "Python 3"); then
  log_info "Installing python"
  brew install python && log_success "Python successfully installed"
else
  log_success "Python3 already instaled"
fi

# FIXME: make sure the pip and python links point to python3

pip install --user pipenv
