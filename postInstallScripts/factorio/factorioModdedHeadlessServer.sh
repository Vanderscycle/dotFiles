k#!/bin/bash

echo '------------------------------------------------------------------------'
echo '=> Ubuntu 20.04LTS Factorio Headless Server modded'
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
ufw allow 34197/udp # unmodded
ufw allow 34198/udp # modded
ufw enable
# verfication
ufw status verbose

# -----------------------------------------------------------------------------
# => Factorio specific (modded)
#https://hub.docker.com/r/dtandersen/factorio/
# -----------------------------------------------------------------------------
echo -e'\n=>Configuring the mod'

#rsync -auv ~/.factorio/mods/mod-list.json root@192.46.223.140:/opt/factorioModded/mods/  
#rsync -auv ~/.factorio/saves/K2SE.zip root@192.46.223.140:/opt/factorioModded/saves/  #saves has to be in a zip format

sudo mkdir -p /opt/factorioModded
sudo chown 845:845 /opt/factorioModded
sudo docker run -d \
  -p 34198:34197/udp \
  -p 27016:27015/tcp \
  -v /opt/factorioModded:/factorio \
  -e LOAD_LATEST_SAVE=false \
  -e SAVE_NAME=K2SE \
  -e UPDATE_MODS_ON_START=true \
  -e USERNAME= \
  -e TOKEN= \
  --name factorioModded \
  --restart=always \
  factoriotools/factorio
