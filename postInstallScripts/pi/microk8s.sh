#!/bin/sh
# tutorial
# https://www.youtube.com/watch?v=wN6FlmPy2qA 
sudo apt-get update && sudo apt-get upgrade -y

sudo apt install -y snapd
sudo apt install -y docker.io
sudo snap install microk8s --classic
sudo snap install kubectl --classic
sudo snap install helm --classic
curl -s https://kustomizer.dev/install.sh | bash

# testing microk8s

sudo microk8s enable dashboard dns ingress registry

sudo microk8s status #inspect
sudo microk8s kubectl get nodes
sudo microk8s kubectl get services

microk8s kubectl get po --all-namespaces

sudo usermod -a -G microk8s "$USER"
sudo chown -f -R pi ~/.kube

#installing go
sudo apt install -y golang

#installing fish shell for a better ssh experience
sudo apt install -y fish
sudo chsh -s $(which fish) $(whoami)
# curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher # like zplug
# fisher install jethrokuan/z #zoxide?
# fisher install ilancosman/tide #use that or starship
# fisher install PatrickF1/fzf.fish #fzf but fish
