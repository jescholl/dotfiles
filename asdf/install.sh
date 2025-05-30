#!/bin/bash

if command -v asdf; then
  asdf plugin add terraform https://github.com/asdf-community/asdf-hashicorp.git
  asdf plugin add terragrunt https://github.com/ohmer/asdf-terragrunt.git
  asdf plugin add nomad https://github.com/asdf-community/asdf-hashicorp.git
  asdf plugin add vault https://github.com/asdf-community/asdf-hashicorp.git
  asdf plugin add consul https://github.com/asdf-community/asdf-hashicorp.git
  asdf plugin add python https://github.com/danhper/asdf-python.git
  asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
  asdf plugin add pre-commit https://github.com/jonathanmorley/asdf-pre-commit.git
  asdf plugin add tfsec https://github.com/woneill/asdf-tfsec.git
  asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
  asdf plugin add argocd https://github.com/beardix/asdf-argocd.git
  asdf plugin add sops https://github.com/feniix/asdf-sops.git

  asdf install
  asdf reshim
else
  echo "WARNING: asdf not installed"
fi
