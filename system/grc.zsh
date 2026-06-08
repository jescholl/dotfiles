# GRC colorizes nifty unix tools all over the place
if (( $+commands[grc] )); then
  if (( $+commands[brew] )); then
    source "$(brew --prefix)/etc/grc.zsh"
  else
    echo "Unable to find grc.zsh"
  fi
fi



# override grc function for kubectl so that STDIN/STDOUT attachments work properly
kubectl() {
  local real="${commands[$0]}"
  case "$1" in
    exec|attach|debug|run)
      "$real" "$@"
      ;;
  *)
    grc --colour=auto "$real" "$@"
    ;;
  esac
}
