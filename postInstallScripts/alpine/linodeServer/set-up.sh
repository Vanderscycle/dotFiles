#!/bin/bash

# purging previous files
echo -e '\n=>Purging previous files'
DIR='/home/root/maas/'
if [ -d "$DIR" ]; then
  rm -rf "$DIR"
fi
mkdir ~/maas/
echo -e 'Done.\n'

#TODO: when first configured add a quick variable to the .env file to act as a flag
echo -e '\n=>Installing the bare minimum(podman)'
# sudo pacman -Syu
# sudo pacman -S --needed --noconfirm podman-compose podman ufw git rsync buildah fuse3 fuse-overlayfs
# echo -e 'Done.\n'

# echo -e '\n=>Configuring podman/buildah'
# sudo touch /etc/containers/registries.conf.d/docker.conf 
# echo 'unqualified-search-registries=["docker.io"]' > /etc/containers/registries.conf.d/docker.conf
# sudo touch /etc/subuid
# sudo touch /etc/subgid 
# sudo usermod --add-subuids 200000-201000 --add-subgids 200000-201000 root

# sudo mkdir -p /root/buildah
echo -e 'Done.\n'

echo -e '\n=> Installing Docker'
# ctop is a vizualization tool for docker
# sudo pacman -S --noconfirm --needed docker ctop

# sudo systemctl start docker
# sudo systemctl enable docker # allows it to start on start
# sudo systemctl status docker # visual confirmation

# echo -e '\n=> Installing Docker compose'
# sudo pacman -S --noconfirm docker-compose

# echo -e 'Removing Sudo requirements'
# sudo groupadd docker
# sudo usermod -aG docker ${USER}
echo -e 'Done.\n'
