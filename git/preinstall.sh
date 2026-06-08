#!/bin/bash
if ! [ -f "$DOTFILES_SCRATCH/gitconfig.dynamic.symlink" ]; then
  source "$DOTFILES_ROOT/bootstrap/functions"
  git_credential='cache'
  if [ "$(uname -s)" == "Darwin" ]; then
    git_credential='osxkeychain'
  fi

  user ' - What is your github author name?'
  read -re git_authorname
  user ' - What is your github author email?'
  read -re git_authoremail

  awk \
    -v authorname="$git_authorname" \
    -v authoremail="$git_authoremail" \
    -v credential="$git_credential" \
    -v dotfiles_root="$DOTFILES_ROOT" \
    '{
      gsub(/#AUTHORNAME#/, authorname);
      gsub(/#AUTHOREMAIL#/, authoremail);
      gsub(/#GIT_CREDENTIAL_HELPER#/, credential);
      gsub(/#DOTFILES_ROOT#/, dotfiles_root);
      print
    }' \
    "$DOTFILES_ROOT/git/gitconfig.dynamic.symlink.template" > "$DOTFILES_SCRATCH/gitconfig.dynamic.symlink"

  log_success 'gitconfig'
fi
