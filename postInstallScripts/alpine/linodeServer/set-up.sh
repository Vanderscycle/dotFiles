#!/bin/bash

echo -e '\n=>Installing the bare minimum'
#https://www.linuxshelltips.com/install-go-alpine-linux/

#community packages
cat > /etc/apk/repositories << EOF; $(echo)
https://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/main/
https://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community/
https://dl-cdn.alpinelinux.org/alpine/edge/testing/
EOF

apk update
apk add --update --no-cache go git make musl-dev curl rsync ufw

#Go env
export GOPATH=/root/go
export PATH=${GOPATH}/bin:/usr/local/go/bin:$PATH
export GOBIN=$GOROOT/bin
mkdir -p ${GOPATH}/src ${GOPATH}/bin
export GO111MODULE=on

go version

#firewall config
ufw default allow outgoing
ufw default deny incoming
ufw allow ssh
yes | ufw enable
ufw status #confirmatio 
#WIP: do not forget to add the port that must be openened e.g. 5000/3000

echo -e 'Done.\n'

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
