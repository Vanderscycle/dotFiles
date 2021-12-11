# !/bin/bash

# sudo pacman -S --needed --noconfirm httpie && http  --download https://raw.githubusercontent.com/Vanderscycle/dot-config/main/postInstallScripts/endeavourOS/endeavourOSXmonad.sh && chmod +x ./endeavourOSXmonad.sh %% bash ./endeavourOSXmonad.sh
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

echo -e '\n=> importing our doots'
git clone git@github.com:Vanderscycle/dot-config.git ~/Documents/doots/
echo -e 'Done.\n'


echo -e '\n=> install the window manager'
#TODO: install a better terminal than xterm(kitty)
sudo pacman -S --needed --noconfirm xmonad xmonad-contrib kitty dmenu
mkdir -p ~/.xmonad/
echo "downloading"
http  --download https://raw.githubusercontent.com/Vanderscycle/dot-config/main/postInstallScripts/endeavourOS/xmonad.hs > ~/.xmonad/xmonad.hs
echo -e 'Done.\n'

