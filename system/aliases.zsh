# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null); then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

alias mysql='docker run --rm -it mariadb mysql'

alias tg=tf

function tf () {
  if [ -f "terragrunt.hcl" ]; then
    terragrunt ${@}
  else
    terraform ${@}
  fi
}
