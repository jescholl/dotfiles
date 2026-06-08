#!/bin/bash

if command -v asdf; then
  add_plugin() {
    asdf plugin list | grep -q "^$1$" || asdf plugin add "$1" "$2"
  }

  add_plugin terraform https://github.com/asdf-community/asdf-hashicorp.git
  add_plugin terragrunt https://github.com/ohmer/asdf-terragrunt.git
  add_plugin nomad https://github.com/asdf-community/asdf-hashicorp.git
  add_plugin vault https://github.com/asdf-community/asdf-hashicorp.git
  add_plugin consul https://github.com/asdf-community/asdf-hashicorp.git
  add_plugin python https://github.com/danhper/asdf-python.git
  add_plugin ruby https://github.com/asdf-vm/asdf-ruby.git
  add_plugin pre-commit https://github.com/jonathanmorley/asdf-pre-commit.git
  add_plugin tfsec https://github.com/woneill/asdf-tfsec.git
  add_plugin golang https://github.com/asdf-community/asdf-golang.git
  add_plugin argocd https://github.com/beardix/asdf-argocd.git
  add_plugin sops https://github.com/feniix/asdf-sops.git

  asdf install
  asdf reshim
else
  echo "WARNING: asdf not installed"
fi
