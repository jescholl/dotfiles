# init according to man page
if (( $+commands[pyenv] )); then
  eval "$(pyenv init --no-rehash -)"
fi