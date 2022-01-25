#!/bin/bash
echo -e "=> Purging previous files"
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh)
# from the official website
echo -e "=> fetching the lvim files from source"
curl -o ~/install.sh https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh
export LV_BRANCH=rolling 
sudo bash ~/install.sh  --no-install-dependencies 
rm ~/install.sh
# neovim bins
echo -e "=> fetching nvim latest binaries"
sudo bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release)
# syncing my doots
echo -e "=> syncing doots"
bash ~/Documents/dotFiles/postInstallScripts/syncDootsLocal.sh

