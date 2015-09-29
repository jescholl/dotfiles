#!/bin/sh
source ${DOTFILES_ROOT}/bootstrap/functions

for plugin in `cat vim.plugins`; do
  dir=${DOTFILES_ROOT}/__dotfiles_scratch__/vim-bundle/$(echo $plugin | sed 's/^.*\///')

  git clone -q "https://${plugin}" $dir 2> /dev/null ||
    (pushd > /dev/null $dir && \
    git fetch origin -q && \
    git clean -fq && \
    git reset --hard origin/master -q && popd > /dev/null)


  if [ $? == 0 ]; then
    success "Cloned ${plugin}"
  else
    fail "Failed to clone ${plugin}"
  fi
done
