#!/bin/bash

# first version in the list becomes default
ruby_versions=(2.5.5)

source "$DOTFILES_ROOT/bootstrap/functions"
rbenv_path="$HOME/.rbenv"
rbenv="$rbenv_path/bin/rbenv"

link_file "$DOTFILES_SCRATCH/ruby/tools/rbenv" "$HOME/.rbenv"
for file in "$DOTFILES_SCRATCH/ruby/tools/rbenv/bin/"*; do
  link_file "$file" "$DOTFILES_SCRATCH/bin/$(basename "$file")"
done

for version in "${ruby_versions[@]}"; do
  log_info "Installing ruby $version"
  if "$rbenv" versions | grep -q " *$version *"; then
    log_success "  already installed"
  elif "$rbenv" install "$version" > "/tmp/rbenv-install-$version.log" 2>&1; then
    log_success "  installed ruby $version"
  else
    log_fail "  failed to install ruby $version"
  fi
done

echo "${ruby_versions[0]}" > "$rbenv_path/version"
