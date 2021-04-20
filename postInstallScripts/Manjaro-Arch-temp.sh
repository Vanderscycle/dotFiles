
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
cd ~/Programs/yay/ && makepkg -si --noconfirm --needed

echo -e 'Installing Nvidia drivers'
sudo pacman -S nvidia nvidia-utils    # NVIDIA 
echo -e 'Installing process managers (htop/gotop)'
yay -S --noconfirm gotop-bin htop
echo -e 'Done.\n'


# -----------------------------------------------------------------------------
# => Install developer packages
# -----------------------------------------------------------------------------

echo -e '\n=> Installing developer packages'
echo -e 'Installing Text Editior (neovim)'
git clone https://aur.archlinux.org/neovim-nightly-bin.git ~/Programs/neovim/ 
cd ~/Programs/neovim/ && makepkg -si --noconfirm --needed
echo -e 'Installing Tmux'
pacman -S --noconfirm tmux
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
# need to pass commands directly investigate
sudo su postgres -l # or sudo -u postgres -i
initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data/'
exit

sudo systemctl start postgresql
sudo systemctl enable postgresql # allows it to start on start
sudo systemctl status postgresql # visual confirmation

echo -e 'Installing Mongo'
git clone https://aur.archlinux.org/mongodb-bin.git ~/Programs/mongo/
cd ~/Programs/mongo/ && makepkg -si --noconfirm --needed

echo -e 'Configuring Mongo'
sudo systemctl start mongodb
sudo systemctl enable mongodb # allows it to start on start
sudo systemctl status mongodb # visual confirmation

# -----------------------------------------------------------------------------
# => Local application (local machine only)
# -----------------------------------------------------------------------------
echo '\n=> Installing local machine applications'
echo -e 'Installing Torrent client (Transmission)'
# more investigation required
git clone https://aur.archlinux.org/transmission-cli-git.git ~/Programs/transmission/
cd ~/Programs/transmission/ && makepkg -si --noconfirm --needed

echo -e 'Installing Window manager (bspwm)' # what a pain 
sudo pacman -S --noconfirm xorg xorg-xinit bspwm sxhkd dmenu nitrogen picom arandr
#sxhkd for keybindings
#arandr fo rmultple screens
mkdir ~/.config/bspwm/
mkdir ~/.config/sxhkd/
cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/
cp /etc/X11/xinit/xinitrc ~/.xinitrc

cat >> ~/.xinitrc << EOF
sextkbmap ch &
picom -f &
exec bspwm
EOF

CONFIG="/etc/xdg/picom.conf"
if grep -Fq "vsync = true" $CONFIG
then
    OLD="'vsync = true'"
    NEW="'#vsync = true'"
    sed -i "s%$OLD%$NEW%g" $CONFIG
fi


sudo touch /etc/X11/Xwrapper.config
sudo cat >> /etc/X11/Xwrapper.config << EOF
allowed_users = anybody
needs_root_rights = no
EOF

echo -e 'Installing remote working software (zoom/discord)'
yay -S --noconfirm zoom
yay -S --noconfirm discord

echo -e 'Installing entertainment (steam/spotify)'
yay -S --noconfirm ncspot #command line client for spotify (may want to move to Ncmpcpp later)
yay -S --noconfirm vlc

echo -e 'Installing web browser'
yay -S --noconfirm brave
