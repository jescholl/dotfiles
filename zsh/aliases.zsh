alias reload!='. ~/.zshrc'

#alias prun='pipenv run'
alias be='bundle exec'
alias dc="docker-compose"
alias knife="be knife"
alias wx="curl wttr.in/Portland"
alias ls="exa"
alias cat="bat"
alias cdm="cd \$(hcl2json terragrunt.hcl | jq -r '.terraform[].source')"

alias pcp="pwd; pwd | pbcopy"


#alias ansible="prun ansible"
