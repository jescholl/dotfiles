periodic_rehash() {
  local pyenv_tracker="$DOTFILES_SCRATCH/python/tracker"
  local frequency_seconds=2592000 # 1 month
  if ! [ -f "$pyenv_tracker" ] || [ "$(date -r "$pyenv_tracker" "+%s")" -lt "$(($(date "+%s") - $frequency_seconds))" ]; then
    [ -d "$pyenv_tracker" ] || mkdir -p "$(dirname "$pyenv_tracker")"
    touch "$pyenv_tracker"
    pyenv rehash
  fi
}

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if (( $+commands[pyenv] )); then
  eval "$(pyenv init --path)"
  eval "$(pyenv init --no-rehash -)"
fi

periodic_rehash
