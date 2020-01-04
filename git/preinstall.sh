#!/bin/bash

source "$DOTFILES_ROOT/bootstrap/functions"

module_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1; pwd)"
echo "$module_path"
exit 0



if ! [ -f "$DOTFILES_SCRATCH/gitconfig.dynamic.symlink" ]; then
  source "$DOTFILES_ROOT/bootstrap/functions"
  GIT_CREDENTIAL_HELPER='cache'
  if [ "$(uname -s)" == "Darwin" ]; then
    GIT_CREDENTIAL_HELPER='osxkeychain'
  fi

  user ' - What is your github author name?'
  read -re AUTHORNAME
  user ' - What is your github author email?'
  read -re AUTHOREMAIL

  render_templates

  #sed \
  #  -e "s/#AUTHORNAME#/$git_authorname/g" \
  #  -e "s/#AUTHOREMAIL#/$git_authoremail/g" \
  #  -e "s/#GIT_CREDENTIAL_HELPER#/$git_credential/g" \
  #  -e "s!#DOTFILES_ROOT#!$DOTFILES_ROOT!g" \
  #  "$DOTFILES_ROOT/git/gitconfig.dynamic.symlink.template" > "$DOTFILES_SCRATCH/gitconfig.dynamic.symlink"

  log_success 'gitconfig'
fi
