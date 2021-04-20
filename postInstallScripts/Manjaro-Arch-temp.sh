
#!/bin/bash
# Manjaro post-install script

cd ~
echo '------------------------------------------------------------------------'
echo '=> Manjaro 20.04LTS post-install script'
echo '=> Before reboot'
echo '------------------------------------------------------------------------'


echo -e '\n=> Update repository information'
# -S: synchronize your system's packages with those in the official repo
# -y: download fresh package databases from the server
# -u: upgrade all installed packages (like rsync)
# --noconfirm
echo -e '=> Perform system upgrade'
sudo pacman -Syu
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Install system utilities
# -----------------------------------------------------------------------------

echo -e '\n=> Installing system utilities'
echo -e 'Installing AUR helper (yay)'
# Arch User Repository (AUR) helper helps with the installation of packages from the AUR.
mkdir ~/Programs/
git clone https://aur.archlinux.org/yay.git ~/Programs/yay/ #Aur helper
cd ~/Programs/yay/
makepkg -si --noconfirm --needed
echo -e 'Done.\n'


# -----------------------------------------------------------------------------
# => Install developer packages
# -----------------------------------------------------------------------------

echo -e '\n=> Installing developer packages'
echo -e 'Installing Text Editior (neovim)'
git clone https://aur.archlinux.org/neovim-nightly-bin.git ~/Programs/neovim/ 
cd ~/Programs/neovim/
makepkg -si --noconfirm --needed
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Docker
# -----------------------------------------------------------------------------

echo -e 'Installing Docker'
sudo pacman -S --noconfirm Docker
# https://wiki.archlinux.org/index.php/Docker
# https://docs.docker.com/config/daemon/
# touch /etc/docker/daemon.json # for specific user config
sudo systemctl start docker
sudo systemctl enable docker # allows it to start on start
sudo systemctl status docker # visual confirmation

echo -e 'Installing Docker compose'
sudo pacman -S --noconfirm docker-compose

echo -e 'Removing Sudo requirements'
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker

# -----------------------------------------------------------------------------
# => Miniconda
# -----------------------------------------------------------------------------

echo -e 'Installing Miniconda'
yay -S --noconfirm miniconda3

echo -e 'Configuring python env with basic package'
conda init
conda create -y -n dev-branch python
conda activate dev-branch
conda install -y pandas numpy django 
pip3 install pynvim # required for neovim

# -----------------------------------------------------------------------------
# => Databases
# --------------------------------------------/etc/init.d/ postgresql postgresql-contrib

echo -e 'Installing Postgresql'
# https://lobotuerto.com/blog/how-to-install-postgresql-in-manjaro-linux/
yay -S --noconfirm postgresql postgis

echo -e 'Configuring Postgresql'
sudo su postgres -l # or sudo -u postgres -i
initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data/'
exit

sudo systemctl start postgresql
sudo systemctl enable postgresql # allows it to start on start
sudo systemctl status postgresql # visual confirmation
