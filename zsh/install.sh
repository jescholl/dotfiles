#!/bin/bash
source "$DOTFILES_ROOT/bootstrap/functions"

if [ "$SHELL" == "$(command -v zsh)" ]; then
  log_success "zsh is already set as shell"
else
  if chsh -s "$(command -v zsh)"; then
    log_success "Changed shell to zsh"
  else
    log_failure "Unable to set shell to zsh"
  fi
fi
