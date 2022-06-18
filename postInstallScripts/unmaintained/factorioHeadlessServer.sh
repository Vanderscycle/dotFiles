#!/bin/bash

echo '------------------------------------------------------------------------'
echo '=> Ubuntu 20.04LTS Factorio Headless Server unmodded'
echo '------------------------------------------------------------------------'
# -----------------------------------------------------------------------------
# => Server set-up w/ ufw
# -----------------------------------------------------------------------------

# TODO: make it so that it asks you the location and name of the save file.
sudo adduser --disabled-login --no-create-home --gecos factorio factorio

echo -e '\n=> Update repository information '
sudo apt-get update -qq #-qq for quiet
echo -e '=> Perform system upgrade'
sudo apt-get dist-upgrade -y
echo -e 'Done.\n'

echo -e '\n=> Installing system utilities'
sudo apt-get install -y --no-install-recommends ufw fail2ban tree

echo -e '\n=> Configuring the firewall'
ufw default allow outgoing
ufw default adeny incoming
ufw allow ssh
ufw allow 8000
ufw allow 34197/udp
ufw enable
# verfication
ufw status verbose

# -----------------------------------------------------------------------------
# => Docker (debian) Docker-compose
# https://docs.docker.com/engine/install/debian/
# -----------------------------------------------------------------------------
echo -e '=> Removing old docker version (if present) Docker' 
sudo apt-get purge docker-ce
echo -e'\n=> Installing Docker' 
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
docker version
echo -e '\n=> Removing Sudo requirement Docker' 
sudo usermod -aG docker ${USER}
echo -e '\n=> Enabling Docker to start upon boot' 
sudo systemctl enable docker
sudo systemctl start docker
echo '=> Removing docker installation file' 
rm get-docker.sh
echo -e'\n=> Installing Docker-compose' 
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Factorio specific (unmodded)
#https://hub.docker.com/r/dtandersen/factorio/
# -----------------------------------------------------------------------------

#image
# https://github.com/factoriotools/factorio-docker
echo -e'\n=> Pulling the Docker image'
sudo mkdir -p /opt/factorio
sudo chown 845:845 /opt/factorio
sudo docker run -d \
  -p 34197:34197/udp \
  -p 27015:27015/tcp \
  -v /opt/factorio:/factorio \
  --name factorio \
  --restart=always \
  factoriotools/factorio
echo -e 'Done.\n'

#sudo vi /etc/systemd/system/factorio.service
echo -e'\n=>Configurating systemd'
#cat >> /etc/systemd/system/factorio.service << EOF
#[Unit]
#Description=Factorio Headless Server
#
#[Service]
#Type=simple
#User=factorio
#ExecStart=/opt/factorio/bin/x64/factorio --start-server-load-latest --server-settings /opt/factorio/data/server-settings.json
#EOF
#systemctl daemon-reload
echo -e 'Done.\n'

echo -e'\n=>Creating the user'
cd /opt/factorio
sudo adduser --disabled-login --no-create-home --gecos factorio factorio
sudo chown -R factorio:factorio /opt/factorio
cd /opt/factorio/config/
# ask the user what the password is (use input)
su factorio
echo -e 'Done.\n'



#move the save from your machine to the server 
#rsync -auv ~/Downloads/bruuu2.zip root@192.46.223.140:/opt/factorio/saves/  #saves has to be in a zip format

#factorio connection 
#192.46.223.140:34197

# access the logs inside
#docker exec -it factorio bash

#need to add an update script
# also need to add a modded version (different port??)
