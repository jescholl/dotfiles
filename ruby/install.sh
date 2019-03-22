#!/bin/sh
source ${DOTFILES_ROOT}/bootstrap/functions

if test ! $(which rbenv)
then
  echo "  Installing rbenv for you."
  brew install rbenv > /tmp/rbenv-install.log
fi

if test ! $(which ruby-build)
then
  echo "  Installing ruby-build for you."
  brew install ruby-build > /tmp/ruby-build-install.log
fi

for version in 2.4.3 2.5.0 2.5.5; do
        if [ `rbenv versions | grep "^\s*$version\s*$"` ]; then
          success "skipped rbenv ruby $version, already installed"
                continue
        fi

  rbenv install $version

        if [ $? == 0 ]; then
          success "installed rbenv ruby $version"
        else
                fail "failed to install rbenv ruby $version"
        fi
done

echo 2.5 > ~/.rbenv/version

rbenv rehash
