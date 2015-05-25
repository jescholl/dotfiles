#!/bin/sh

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

rbenv install 1.9.3-p385
rbenv install 2.0.0-p353
rbenv install 2.1.2
rbenv install 2.2.2

rbenv rehash
