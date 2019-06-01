#!/bin/bash
if ! [ -f "$DOTFILES_SCRATCH/bashrc.symlink" ]; then
  source "$DOTFILES_ROOT/bootstrap/functions"
  sed -e "s!#DOTFILES_ROOT#!$DOTFILES_ROOT!g" "$DOTFILES_ROOT/bash/bashrc.symlink.template" > "$DOTFILES_SCRATCH/bashrc.symlink"

  log_success 'bashrc'
fi
