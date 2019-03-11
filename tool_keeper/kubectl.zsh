tool_keeper_kubectl_latest_version() {
  curl -Ls https://storage.googleapis.com/kubernetes-release/release/stable.txt
}

tool_keeper_kubectl_install() {
  local version=$1
  local tool_path=${tools_dir}/kubectl-${version}
  curl -Lso ${tool_path} https://storage.googleapis.com/kubernetes-release/release/${version}/bin/darwin/amd64/kubectl
  chmod +x ${tool_path}
}

kubectl() {
  [ -z "$tools_dir" ] && source $DOTFILES_ROOT/tool_keeper/funcs.zsh
  run_tool kubectl "$@"
}

_kubectl_lazy_completion() {
  source <(kubectl completion zsh)
  unset -f _kubectl_lazy_completion
}

compdef _kubectl_lazy_completion kubectl
