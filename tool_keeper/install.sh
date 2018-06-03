#!/bin/bash
source ${DOTFILES_ROOT}/bootstrap/functions

# kubectl
install_kubectl() {
  local version=$1

  tmpdir=$(mktemp -dt kubectl-${kubectl_version})

  curl -Lso ${tmpdir}/kubectl https://storage.googleapis.com/kubernetes-release/release/${version}/bin/darwin/amd64/kubectl && \
    chmod +x ${tmpdir}/kubectl && \
    sudo mv ${tmpdir}/kubectl /usr/local/bin/kubectl-${version}

  rm -rf $tmpdir
}

$latest_version=$(curl -Ls https://storage.googleapis.com/kubernetes-release/release/stable.txt)
versions="$KUBECTL_VERSION v1.9.2 $latest_version"
for version in $versions; do
  if [ ! -f ${DOTFILES_SCRATCH}/bin/kubectl-${version} ]; then
    install_kubectl $version
  fi
done

ln -s ${DOTFILES_SCRATCH}/bin/kubectl-${KUBECTL_VERSION:-$latest_version} ${DOTFILES_SCRATCH}/bin/kubectl
