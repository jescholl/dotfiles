#!/bin/bash
source "$DOTFILES_ROOT/bootstrap/functions"

if [ "$SHELL" -ef "$(command -v zsh)" ] || [ "$SHELL" -ef "$(< /etc/shells grep '/zsh$')" ]; then
  log_success "zsh is already set as shell"
else
  log_info "Changing shell to zsh, please enter password"
  if chsh -s "$(< /etc/shells grep -m 1 '/zsh$')"; then
    log_success "  Changed shell to zsh"
  else
    log_fail "  Unable to set shell to zsh"
  fi
fi
