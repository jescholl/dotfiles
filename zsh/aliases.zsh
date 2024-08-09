#!/bin/bash

alias reload!='. ~/.zshrc'

#alias prun='pipenv run'
alias be='bundle exec'
alias dc="docker-compose"
alias knife="be knife"
alias wx="curl wttr.in/Portland"
alias ls="eza"
alias cat="bat"
alias cdm="cd \$(hcl2json terragrunt.hcl | jq -r '.terraform[].source')"

alias pcp="pwd; pwd | pbcopy"


#alias ansible="prun ansible"
#
#

function aws_assume_role() {
  local args=()
  local role_arn="$1"

  aws_cmd=("aws" "sts" "assume-role" "--role-arn" "$role_arn" "--role-session-name" "aws_assume_role_function")
  aws_cmd+=(${args[@]})

  if assume_role_output=$(${aws_cmd[@]}); then
    eval $(echo $assume_role_output | jq -r '.Credentials | "export AWS_ACCESS_KEY_ID=" + .AccessKeyId + "\nexport AWS_SECRET_ACCESS_KEY=" + .SecretAccessKey + "\nexport AWS_SESSION_TOKEN=" + .SessionToken')

    echo "Success: role assumed"
  else
    echo "ERROR"
    echo "CMD: $aws_cmd"
    echo "OUTPUT: $assume_role_output"
  fi

}

function git-cliff() {
  docker run -v "$PWD:/app" -e GIT_CLIFF__GIT__TAG_PATTERN  ghcr.io/orhun/git-cliff/git-cliff:2.2.1 $@
}

function renovate() {
  docker run -v "$PWD:/pwd" -w /pwd -e LOG_LEVEL renovate/renovate:37.347.0-full $@
}
