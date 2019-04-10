_kubectl_lazy_completion() {
  source <(kubectl completion zsh)
  unset -f _kubectl_lazy_completion
}

compdef _kubectl_lazy_completion kubectl
