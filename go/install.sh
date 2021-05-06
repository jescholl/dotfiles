#!/bin/bash
source "${DOTFILES_ROOT}/bootstrap/functions"
GOVERSION=${GOVERSION:-"1.16.3"}
GOROOT=${GOROOT:-"$HOME/go_$GOVERSION"}

mkdir -p "$GOROOT"

if [ ! -f "$GOROOT/bin/go" ]; then
  echo "  Installing Go for you."
  curl "https://dl.google.com/go/go$GOVERSION.darwin-amd64.tar.gz" | tar --strip 1 -zxvC "$HOME/go_$GOVERSION"
fi

if [ -f "$GOROOT/bin/go" ]; then
  log_success "Successfully installed Go to $GOROOT"
else
  log_fail "Go instalation failed"
fi
