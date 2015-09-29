if ! [ -f $DOTFILES_ROOT/__dotfiles_scratch__/gitconfig.symlink ]
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

  sed -e "s/#AUTHORNAME#/$git_authorname/g" -e "s/#AUTHOREMAIL#/$git_authoremail/g" -e "s/#GIT_CREDENTIAL_HELPER#/$git_credential/g" $DOTFILES_ROOT/git/gitconfig.symlink.template > $DOTFILES_ROOT/__dotfiles_scratch__/gitconfig.symlink

  success 'gitconfig'
fi
