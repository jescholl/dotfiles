#!/bin/bash
if ! [ -f "${DOTFILES_SCRATCH}/zshrc.symlink" ]; then
  source "${DOTFILES_ROOT}/bootstrap/functions"
  sed -e "s!#DOTFILES_ROOT#!${DOTFILES_ROOT}!g" "${DOTFILES_ROOT}/zsh/zshrc.symlink.template" > "${DOTFILES_SCRATCH}/zshrc.symlink"
  log_success 'zshrc'
fi
