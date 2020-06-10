periodic_rehash() {
  local rbenv_tracker="$DOTFILES_SCRATCH/ruby/tracker"
  local frequency_seconds=2592000 # 1 month
  if ! [ -f "$rbenv_tracker" ] || [ "$(date -r "$rbenv_tracker" "+%s")" -lt "$(($(date "+%s") - $frequency_seconds))" ]; then
    [ -d "$rbenv_tracker" ] || mkdir -p "$(dirname "$rbenv_tracker")"
    touch "$rbenv_tracker"
    rbenv rehash
  fi
}

# init according to man page
if (( $+commands[rbenv] )); then
  eval "$(rbenv init --no-rehash -)"
fi

periodic_rehash
