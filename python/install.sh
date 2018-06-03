#!/bin/sh
if test ! $(which brew); then
  info "Homebrew not installed, skipping"
elif test ! $(python --version | grep "Python 3")
  info "Installing python"
  brew install python && success "Python successfully installed"
else
  success "Python3 already instaled"
fi
