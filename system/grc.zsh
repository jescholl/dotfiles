# GRC colorizes nifty unix tools all over the place
if (( $+commands[grc] )); then
  if [ -f "/usr/local/etc/grc.zsh" ]; then
    source "/usr/local/etc/grc.zsh"
  elif (( $+commands[brew] )); then
    source "$(brew --prefix)/etc/grc.zsh"
  else
    echo "Unable to find grc.zsh"
  fi
fi
