# !/bin/bash

# sudo pacman -S --needed --noconfirm httpie && http  --download https://raw.githubusercontent.com/Vanderscycle/dot-config/main/postInstallScripts/endeavourOS/endeavourOSXmonad.sh && chmod +x ./endeavourOSXmonad.sh && bash ./endeavourOSXmonad.sh
cd ~
echo '------------------------------------------------------------------------'
echo '=> EndavorOs post-install script'
echo 'Current os version: Atantis'
echo 'wm: Xmonad w/ Xmobar'
echo '------------------------------------------------------------------------'

echo -e '\n=> Update repository information'
# -S: synchronize your system's packages with those in the official repo
# -y: download fresh package databases from the serverrm
echo -e '=> Perform system upgrade'
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel git 
echo 'cli download programs'
sudo pacman -S --needed --noconfirm httpie curl

sudo -- sh -c "echo Defaults env_reset,timestamp_timeout=300 >> /etc/sudoers"
echo -e 'Done.\n'

#INFO: configure ssh before using ssh
echo -e '\n=> importing our doots'
git clone https://github.com/Vanderscycle/dot-config.git ~/Documents/
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Install system utilities
# -----------------------------------------------------------------------------


echo -e '\n=> Installing system utilities'
echo -e 'Installing AUR helper (yay)'
sudo pacman -S --noconfirm --needed yay
echo -e '\n=> Installing zsh'


echo '=>Rust and cargo'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install --branch main --git https://github.com/Kampfkarren/selene selene
cargo install stylua  
echo -e 'Done.\n'

echo -e 'Installing nodeJs'
sudo pacman -S --noconfirm --needed nodejs
yay -S --noconfirm  htop
echo -e 'Done.\n'

echo -e '\n=> Installing Kitty'
sudo pacman -S --noconfirm kitty
echo -e 'Done.\n'

echo -e '\n=> Installing Tmux and tmuxinator'
sudo pacman -S --noconfirm tmux
yay -S --noconfirm --needed tmuxinator
echo -e 'Done.\n'

echo -e '\n=> Installing systemctl moditor (fzf)'
yay -S --noconfirm --needed sysz

echo -e '\n=> Installing developer packages and useful tui alternatives'
sudo pacman -S --noconfirm rsync git fzf jq github-cli bat exa ripgrep lazygit htop unzip


# -----------------------------------------------------------------------------
# => Font
# -----------------------------------------------------------------------------

echo -e 'Nerdfont'
mkdir -p ~/.local/share/fonts/ttf/
#TODO: use this address to download the font
#https://www.jetbrains.com/lp/mono/
mkdir -p ~/.local/share/fonts/ttf/
unzip ~/Documents/dotFiles/JetBrainsMono-2.242.zip ~/.local/share/
fc-cache -vf
echo -e 'Done.\n'


# -----------------------------------------------------------------------------
# => Keyboard Languages (en/cn)
# -----------------------------------------------------------------------------

echo -e 'Adding keyboard languages (cn)'
#https://classicforum.manjaro.org/index.php?topic=1044.0
# TODO: add --no needed 
sudo pacman -S ibus-libpinyin opendesktop-fonts
sudo pacman -Ss chinese
sudo sh -c "cat >> /etc/environment <<EOF
GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus
EOF"
# https://wiki.archlinux.org/title/IBus
touch ~/.config/autostart/ibus-daemon.desktop
cat >> ~/.config/autostart/ibus-daemon.desktop <<EOF
[Desktop Entry]
Type=Application
Name=IBus Daemon
Exec=ibus-daemon -drx
EOF
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Databases
# -----------------------------------------------------------------------------

echo -e 'Installing Postgresql'
# https://lobotuerto.com/blog/how-to-install-postgresql-in-manjaro-linux/

yay -S --noconfirm postgresql postgis

echo -e 'Configuring Postgresql'
# need to pass commands directly investigate
sudo su postgres -l <<EOF # or sudo -u postgres -i
initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data/'
EOF
echo -e 'Done.\n'

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
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Window manager
# -----------------------------------------------------------------------------

echo -e '\n=> install the window manager'
#TODO: install a better terminal than xterm(kitty)
sudo pacman -S --needed --noconfirm xmonad xmonad-contrib kitty dmenu
mkdir -p ~/.xmonad/
echo "downloading"
http  --download https://raw.githubusercontent.com/Vanderscycle/dot-config/main/postInstallScripts/endeavourOS/xmonad.hs > ~/.xmonad/xmonad.hs
echo -e 'Done.\n'

