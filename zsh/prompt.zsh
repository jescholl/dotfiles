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

export RPROMPT="%(?..{%{$fg[red]%}%?%{$reset_color%}} )%{$fg_bold[green]%}%*%{$reset_color%}"

prompt_clock() {
  echo "%(?..{%{$fg[red]%}%?%{$reset_color%}} )%{$fg_bold[green]%}%*%{$reset_color%}"
}

PROMPT=$'\n$(prompt_clock) $(directory_name) $(gitprompt)\n› '
RPROMPT=""
VIRTUAL_ENV_DISABLE_PROMPT=1
