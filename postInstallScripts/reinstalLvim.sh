#!/bin/bash
echo -e 'downloading the latest bins from source' 
curl -o ~/uninstall.sh https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh
curl -o ~/install.sh https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh
curl -o ~/binstall.sh https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release
chmod +x ~/**stall.sh

echo -e "=> Purging previous files"
sudo bash ~/uninstall.sh
rm ~/uninstall.sh

echo -e "=> Installing nvim latest bins"
sudo bash ~/binstall.sh
rm ~/binstall.sh

echo -e "=> fetching the lvim files from source"
export LV_BRANCH=rolling 
sudo bash ~/install.sh  --no-install-dependencies 
rm ~/install.sh


echo -e "=> syncing doots"
bash ~/Documents/dotFiles/postInstallScripts/syncDootsLocal.sh

echo -e "=> refreshing dunst"
bash ~/Documents/dotFiles/dunst/reloadDunst.sh

