#!/bin/sh
# tutorial
# https://www.youtube.com/watch?v=wN6FlmPy2qA 
sudo apt-get update && sudo apt-get upgrade -y

sudo apt install snapd
sudo snap install microk8s --classic
sudo snap install kubectl --classic
# testing microk8s

sudo microk8s enable dashboard dns ingress registry

sudo microk8s status #inspect
sudo microk8s kubectl get nodes
sudo microk8s kubectl get services

microk8s kubectl get po --all-namespaces

sudo usermod -a -G microk8s "$USER"
sudo chown -f -R pi ~/.kube
