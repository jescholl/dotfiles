#!/bin/sh
source ${DOTFILES_ROOT}/bootstrap/functions
GOVERSION=${GOVERSION:-"1.9.3"}
GOROOT=${GOROOT:-"$HOME/go_$GOVERSION"}

mkdir -p $GOROOT

if [ ! -f $GOROOT/bin/go ]; then
  echo "  Installing Go for you."
  curl https://dl.google.com/go/go$GOVERSION.darwin-amd64.tar.gz | tar --strip 1 -zxvC $HOME/go_$GOVERSION
fi

if [ -f "$GOROOT/bin/go" ]; then
  success "Successfully installed Go to $GOROOT"
else
  fail "Go instalation failed"
fi