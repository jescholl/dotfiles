#!/bin/bash
source "${DOTFILES_ROOT}/bootstrap/functions"

cat <<EOT > "${DOTFILES_SCRATCH}/env.dotfiles.sh.symlink"
export DOTFILES_ROOT="${DOTFILES_ROOT}"
export DOTFILES_SCRATCH="${DOTFILES_SCRATCH}"
EOT

log_success 'Dotfiles environment variables'
