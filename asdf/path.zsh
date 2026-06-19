# Intentionally NOT sourcing asdf-golang's set-env.zsh: its GOROOT export freezes the
# Go version in non-interactive shells. Unset GOROOT = each `go` self-resolves per dir.
export GOBIN="$HOME/go_bin"
export PATH="$PATH:$GOBIN"
