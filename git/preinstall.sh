#!/bin/bash
if ! [ -f $DOTFILES_SCRATCH/gitconfig.symlink ]
then
    source $DOTFILES_ROOT/bootstrap/functions
  git_credential='cache'
  if [ "$(uname -s)" == "Darwin" ]
  then
    git_credential='osxkeychain'
  fi

  user ' - What is your github author name?'
  read -e git_authorname
  user ' - What is your github author email?'
  read -e git_authoremail

  sed \
    -e "s/#AUTHORNAME#/$git_authorname/g" \
    -e "s/#AUTHOREMAIL#/$git_authoremail/g" \
    -e "s/#GIT_CREDENTIAL_HELPER#/$git_credential/g" \
    -e "s!#DOTFILES_ROOT#!$DOTFILES_ROOT!g" \
    $DOTFILES_ROOT/git/gitconfig.symlink.template > $DOTFILES_SCRATCH/gitconfig.symlink

  log_success 'gitconfig'
fi
