autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh


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
