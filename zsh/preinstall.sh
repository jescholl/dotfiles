if ! [ -f zshrc.symlink ]
then
  if [ -n "$DOTFILES_ROOT" ]; then
    cd "$(dirname "$0")/.."
    DOTFILES_ROOT=$(pwd)
    cd -
  fi
  sed -e "s/DOTFILES_ROOT_PATH/$DOTFILES_ROOT/g" zshrc.symlink.example > zshrc.symlink

  success 'zshrc'
fi
