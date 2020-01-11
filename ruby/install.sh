#!/bin/bash

# first version in the list becomes default
ruby_versions=("2.5.5")

source "${DOTFILES_ROOT}/bootstrap/functions"
# temporarily set path as we install
rbenv_path="$HOME/.rbenv"

if ! command -v rbenv > /dev/null; then
  log_info "Installing rbenv"
  git clone https://github.com/rbenv/rbenv.git "$rbenv_path" > /tmp/rbenv-install.log 2>&1

  # shellcheck disable=SC2015
  cd "$rbenv_path" && src/configure >> /tmp/rbenv-install.log && make -C src >> /tmp/rbenv-install.log || true
fi

if ! "$rbenv_path/bin/rbenv" install -l > /dev/null 2>&1; then
  log_info "Installing ruby-build"
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build >> /tmp/rbenv-install.log 2>&1
fi

for version in "${ruby_versions[@]}"; do
  log_info "Installing ruby $version"
  if "$rbenv_path/bin/rbenv" versions | grep -q " *$version *"; then
    log_success "  already installed"
  elif "$rbenv_path/bin/rbenv" install "$version" > "/tmp/rbenv-install-$version.log" 2>&1; then
    log_success "  installed ruby $version"
  else
    log_fail "  failed to install ruby $version"
  fi
done

echo "${ruby_versions[0]}" > "$rbenv_path/version"

"$rbenv_path/bin/rbenv" rehash
