#!/bin/bash
if ! [ -f "$DOTFILES_SCRATCH/gitconfig.dynamic.symlink" ]; then
  source "$DOTFILES_ROOT/bootstrap/functions"
  git_credential='cache'
  if [ "$(uname -s)" == "Darwin" ]; then
    git_credential='osxkeychain'
  fi

  git_authorname=${GIT_AUTHOR_NAME:-}
  if [[ -z "$git_authorname" ]]; then
    user ' - What is your github author name?'
    read -re git_authorname
    [[ -z "$git_authorname" ]] && { log_fail "Author name cannot be empty"; exit 1; }
  fi
  git_authoremail=${GIT_AUTHOR_EMAIL:-}
  if [[ -z "$git_authoremail" ]]; then
    user ' - What is your github author email?'
    read -re git_authoremail
    [[ -z "$git_authoremail" ]] && { log_fail "Author email cannot be empty"; exit 1; }
  fi

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
