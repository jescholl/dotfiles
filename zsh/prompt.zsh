autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

rb_prompt() {
  ruby_version=$(rbenv version | awk '{print $1}')
  if ! [[ -z "$ruby_version" ]]; then
    echo "%{$fg_bold[yellow]%}$ruby_version%{$reset_color%} "
  else
    echo ""
  fi
}

directory_name() {
  echo "%{$fg[blue]%}%3~%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  export RPROMPT="%{$fg_bold[green]%}%*%{$reset_color%}"
  __git_ps1 $'\n$(rb_prompt)$(directory_name)' $'\n› ' " (%s)"
}
