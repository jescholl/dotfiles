mkdir $DOTFILES_ROOT/__dotfiles_scratch__/vim_undo

ln -s  $DOTFILES_ROOT/_dotfiles_scratch__/vim_undo `cat ./vimrc.symlink | grep undodir | cut -d'=' -f2`
