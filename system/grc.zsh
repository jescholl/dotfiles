# GRC colorizes nifty unix tools all over the place
if (( $+commands[grc] )); then
  if [ -f "/usr/local/etc/grc.bashrc" ]; then
    source "/usr/local/etc/grc.bashrc"
  elif [ -f "/etc/grc.zsh" ]; then
    source "/etc/grc.zsh"
  elif (( $+commands[brew] )); then
    source "$(brew --prefix)/etc/grc.bashrc"
  else
    source /etc/grc.zsh
  fi
fi
