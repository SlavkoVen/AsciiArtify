#!/usr/bin/env bash
set -euxo pipefail
sudo apt-get update
sudo apt-get install -y curl ca-certificates gnupg lsb-release jq bash-completion iproute2 conntrack socat asciinema

# kubectl (автовибір архітектури)
ARCH="$(uname -m)"; case "$ARCH" in x86_64) KARCH=amd64;; aarch64) KARCH=arm64;; *) KARCH=amd64;; esac
KVER="$(curl -sL https://dl.k8s.io/release/stable.txt)"
curl -sL -o kubectl "https://dl.k8s.io/release/${KVER}/bin/linux/${KARCH}/kubectl"
sudo install -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client --output=yaml || true

# k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
k3d version || true

# kind
KIND_VER="v0.23.0"
curl -sL -o kind "https://github.com/kubernetes-sigs/kind/releases/download/${KIND_VER}/kind-linux-${KARCH}"
sudo install -m 0755 kind /usr/local/bin/kind
kind --version || true

# minikube
MINIKUBE_VER="v1.34.0"
curl -sL -o minikube "https://storage.googleapis.com/minikube/releases/${MINIKUBE_VER}/minikube-linux-${KARCH}"
sudo install -m 0755 minikube /usr/local/bin/minikube
minikube version || true

# bash completion (необов’язково приємно)
echo 'source <(kubectl completion bash)' >> ~/.bashrc
echo 'source <(k3d completion bash)' >> ~/.bashrc
echo 'source <(kind completion bash)' >> ~/.bashrc
echo 'source <(minikube completion bash)' >> ~/.bashrc
