sol() {
  light || dark
}

light() {
  set_iterm_theme "Solarized Light"
}

dark() {
  set_iterm_theme "Solarized Dark"
}

set_iterm_theme() {
  local theme_name=$1
  [[ "$theme_name" == "$ITERM_PROFILE" ]] && return 1
  export ITERM_PROFILE=$theme_name
  echo -e "\033]50;SetProfile=$theme_name\a"
  if [[ -n "$DOTFILES_SCRATCH" && -d "$DOTFILES_SCRATCH" ]]; then
    echo ${ITERM_PROFILE##* } | tr '[:upper:]' '[:lower:]' > "$DOTFILES_SCRATCH/vim_background"
  fi
}
