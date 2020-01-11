# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# completion menu
zstyle ':completion:*' menu select


typeset -u completion_files
completion_files=($DOTFILES_ROOT/**/functions/_*)

for func in $completion_files; do
  compdef "${func##*/}" "${func##*/_}"
  autoload "${func##*/}"
done
unset completion_files
