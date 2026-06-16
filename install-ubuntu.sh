#!/bin/bash

set -e
sudo apt update && sudo apt upgrade -y

# essentials
sudo apt install -y \
  build-essential \      # gcc, g++, make
  cmake \
  pkg-config \
  autoconf \
  automake \
  libtool

# libraries
sudo apt install -y \
  git \
  curl \
  unzip \
  zip \
  fzf \
  tree \
  net-tools \
  nmap \
  gnupg \
  ca-certificates \
  apt-transport-https \
  software-properties-common

# install docker
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker "${SUDO_USER:-$USER}" # using user running sudo

# install kubectl
echo "Installing kubectl..."

KUBECTL_VERSION=$(curl -fsSL https://dl.k8s.io/release/stable.txt)
ARCH=$(dpkg --print-architecture)
curl -fsSL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl" -o /tmp/kubectl
# Verify checksum
curl -fsSL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl.sha256" -o /tmp/kubectl.sha256
echo "$(cat /tmp/kubectl.sha256)  /tmp/kubectl" | sha256sum --check
# Install
chmod +x /tmp/kubectl
sudo mv /tmp/kubectl /usr/local/bin/kubectl
rm -f /tmp/kubectl.sha256
kubectl version --client

echo "kubectl ${KUBECTL_VERSION} installed successfully!"

# sdkman
curl -s "https://get.sdkman.io" | bash

# gvm
sudo apt-get install bison
curl -fsSL https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash

# pyenv
curl -fsSL https://pyenv.run | bash

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash



