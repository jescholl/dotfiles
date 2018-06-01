# init according to man page
if (( $+commands[rbenv] ))
then
  eval "$(rbenv init - zsh)"
fi

export RBENV_VERSION=2.4.3
