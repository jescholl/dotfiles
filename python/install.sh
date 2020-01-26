#!/bin/bash

# first version in the list becomes default
python_versions=(3.7.6)

source "$DOTFILES_ROOT/bootstrap/functions"
pyenv_path="$HOME/.pyenv"
pyenv="$pyenv_path/bin/pyenv"

link_file "$DOTFILES_SCRATCH/python/tools/pyenv" "$HOME/.pyenv"
for file in "$DOTFILES_SCRATCH/python/tools/pyenv/bin/"*; do
  link_file "$file" "$DOTFILES_SCRATCH/bin/$(basename "$file")"
done

for version in "${python_versions[@]}"; do
  log_info "Installing python $version"
  if "$pyenv" versions | grep -q " *$version *"; then
    log_success "  already installed"
  elif "$pyenv" install "$version" > "/tmp/pyenv-install-$version.log" 2>&1; then
    log_success "  installed python $version"
  else
    log_fail "  failed to install python $version"
  fi
done

echo "${python_versions[0]}" > "$pyenv_path/version"
