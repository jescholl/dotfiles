#!/bin/bash

asdf plugin add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin add nomad https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin add vault https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin add consul https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin add python https://github.com/danhper/asdf-python.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git

asdf install
asdf reshim
