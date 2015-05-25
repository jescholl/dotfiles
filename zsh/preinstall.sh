if ! [ -f $DOTFILES_ROOT/.template_out/zshrc.symlink ]
then
  source $DOTFILES_ROOT/bootstrap/functions
	sed -e "s!#DOTFILES_ROOT_PATH#!$DOTFILES_ROOT!g" $DOTFILES_ROOT/zsh/zshrc.symlink.template > $DOTFILES_ROOT/.template_out/zshrc.symlink

  success 'zshrc'
fi
