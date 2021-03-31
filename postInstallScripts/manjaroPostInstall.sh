#!/bin/bash
# Manajaro post-install script

function beforeReboot() {
cd ~
echo '------------------------------------------------------------------------'
echo '=> Ubuntu 20.04LTS post-install script'
echo '=> Before reboot'
echo '------------------------------------------------------------------------'


echo -e '\n=> Update repository information '
# -S: synchronize your system's packages with those in the official repo
# -y: download fresh package databases from the server
# -u: upgrade all installed packages (like rsync)
sudo pacman -Syu
echo -e '=> Perform system upgrade'
sudo apt-get dist-upgrade -y
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Install system utilities
# -----------------------------------------------------------------------------

echo -e '\n=> Installing system utilities'
sudo pacman curl wget git lsof gdebi-core \
    zip unzip gzip tar \
    ssh \
    apt-transport-https ca-certificates gnupg lsb-release
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Install developer packages
# cmake used to compile a tmux plugin
# install nodejs nvim (plugin)
# -----------------------------------------------------------------------------

echo -e '\n=> Install developer packages'
sudo pacman -Syu git neovim python3-pip expect tmux rsync cmake
echo -e '\n=> Installing Node JS for py-right'
# More neovim packages
# https://www.chrisatmachine.com/Neovim/08-fzf/
sudo pacman -Syu fzf ripgrep universal-ctags silversearcher-ag fd-find
#https://github.com/neoclide/coc.nvim (node js install)
curl -sL install-node.now.sh/lts | bash
echo -e 'Done.\n'

}
