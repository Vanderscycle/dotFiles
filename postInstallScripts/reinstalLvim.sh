#!/bin/bash
rm -rf ~/.config/lvim ~/.config/lvim.bak
rm -rf ~/.local/share/lunarvim

# from the official website
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh)
LV_BRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
# neovim bins
bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release)
# syncing my doots
bash ~/Documents/dotFiles/postInstallScripts/syncDootsLocal.sh

