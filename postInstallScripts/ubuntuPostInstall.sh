#!/bin/bash
# example https://gist.github.com/rougeth/8108714
# about wget https://unix.stackexchange.com/questions/23501/download-using-wget-to-a-different-directory-than-current-directory

# update_rc.d
# wget -O /etc/init.d/ubuntuPostInstall.sh https://raw.githubusercontent.com/Vanderscycle/ubuntu-dot-config/main/postInstallScripts/ubuntuPostInstall.sh && chmod +x /etc/init.d/ubuntuPostInstall.sh && bash /etc/init.d/ubuntuPostInstall.sh

# Ubuntu post-install script

function beforeReboot() {
cd ~
echo '------------------------------------------------------------------------'
echo '=> Ubuntu 20.04LTS post-install script'
echo '=> Before reboot'
echo '------------------------------------------------------------------------'


echo -e '\n=> Update repository information '
sudo apt-get update -qq #-qq for quiet
echo -e '=> Perform system upgrade'
sudo apt-get dist-upgrade -y
echo -e 'Done.\n'
# -----------------------------------------------------------------------------
# => Install system utilities
# -----------------------------------------------------------------------------

echo -e '\n=> Installing system utilities'
sudo apt-get install -y --no-install-recommends curl wget git lsof gdebi-core \
    zip unzip gzip tar \
    ssh \
    apt-transport-https ca-certificates gnupg lsb-release
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Install developer packages
# -----------------------------------------------------------------------------

echo -e '\n=> Install developer packages'
sudo apt-get install -y --no-install-recommends git neovim python3-pip expect
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Docker (debian)
# https://docs.docker.com/engine/install/debian/
# -----------------------------------------------------------------------------
#! some problem with docker at the moment
echo '=> Removing old docker version (if present) Docker' 
sudo apt-get purge docker-ce
echo -e'\n=> Installing Docker' 
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
docker version
echo -e'\n=> Removing Sudo requirement Docker' 
sudo usermod -aG docker ${USER}
echo -e'\n=> Enabling Docker to start upon boot' 
sudo systemctl enable docker
sudo systemctl start docker
echo '=> Removing docker installation file' 
rm get-docker.sh
echo -e'\n=> Installing Docker-compose' 
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Miniconda
# -----------------------------------------------------------------------------

echo '=> Installing Conda'
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b
export PATH=~/miniconda3/bin:$PATH #.bashrc file
conda init
conda create -y -n dev-branch python
conda activate dev-branch
conda install -y pandas numpy django
rm Miniconda3-latest-Linux-x86_64.sh
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Databases
# --------------------------------------------/etc/init.d/ postgresql postgresql-contrib
echo '=> Starting Postgres'
sudo systemctl enable postgresql
sudo systemctl start postgresql
service postgresql start
echo -e '\n=> Installing MongoDb'
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update
sudo apt-get install -y --no-install-recommends mongodb-org
echo '=> Starting Mongo'
sudo systemctl enable mongod
sudo systemctl start mongod
echo -e 'Done. \n'

# -----------------------------------------------------------------------------
# => Security
# -----------------------------------------------------------------------------

echo '=> Configuring security'
mkdir -p ~/.ssh
sudo chmod 700 ~/.ssh/
sudo chmod 600 ~/.ssh/*
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => if local machine
# -----------------------------------------------------------------------------
echo '\n=> Install favorite applications'
echo '=> spotify discord mailspring vlc vscode gitkraken'
echo -e '=> Are you sure? [Y/n] '
read confirmation
confirmation=$(echo $confirmation | tr '[:lower:]' '[:upper:]')
if [[ $confirmation == 'YES' || $confirmation == 'Y' ]]; then

    sudo apt-get install -y --no-install-recommends vlc code
    snap install spotify discord mailspring discordcd ~
    wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
    sudo dpkg -i gitkraken-amd64.deb


    echo -e 'Done.\n'
fi

# -----------------------------------------------------------------------------
# => Install Terminal Specific
# -----------------------------------------------------------------------------
# https://likegeeks.com/expect-command/
echo -e '\n=> Installing zsh and oh-my-zsh'
sudo apt-get install -y --no-install-recommends zsh
# changing the default from bash to zsheympNjKxG8ki7fN
sudo chsh -s $(which zsh)
# installing oh-my-zsh
#https://github.com/ohmyzsh/ohmyzsh/issues/5873#issuecomment-498678076
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo -e '\nCloning relevant github zsh repo: 10k, zplug, autosuggestion and syntax highlight'
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# adding 2 usefull pluging

echo -e '\ninstalling Nerd Font'
wget https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/install.sh && chmod +x install.sh && bash install.sh
echo -e '\nConfiguring the settings in .zshrc'
CONFIG=".zshrc"
if grep -Fq "ZSH_THEME" $CONFIG
then
        OLD='ZSH_THEME="robbyrussell"'
        NEW="ZSH_THEME='powerlevel10k/powerlevel10k'"
        APPEND="POWERLEVEL10K_MODE='nerdfont-complete'"
        sed -i "s%$OLD%$NEW%g" $CONFIG
        echo $APPEND >> $CONFIG
fi

if grep -Fq "plugins" $CONFIG
then
        OLD="plugins=(git)"
        NEW="plugins=(git zsh-autosuggestions zsh-syntax-highlighting)"
        sed -i "s%$OLD%$NEW%g" $CONFIG
fi
#conda and zplug line
echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >>! ~/.zshrc
cat >> $CONFIG << EOF
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -f ${HOME}/.zplug/init.zsh ]; then
    source ${HOME}/.zplug/init.zsh
fi
export PATH="$PATH:$HOME/miniconda3/bin"

EOF
conda update -y conda
conda init zsh
echo -e '\ninstalling enhancd using zplug'
zplug "b4b4r07/enhancd", use:init.sh

echo -e 'removing installation file'
rm install.sh

echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Get dotfiles
# -----------------------------------------------------------------------------
echo '=> Get dotfiles (https://github.com/Vanderscycle/ubuntu-dot-config)'


# Clone the repository recursively
git clone --recursive https://github.com/Vanderscycle/ubuntu-dot-config ~/.dotfiles

# single dotfile
declare -a StringArray=(.?*) # looks for all dot files 
for DOTFILE in "${StringArray[@]}"; do
    # can't use symbolic link since we want the file
    ln  ~/.dotfiles/$DOTFILE ~/$DOTFILE
done

# folders
mkdir .config/
declare -a StringArray=("nvim")
# Copying all the folders for neovim
for DOTFOLDER in "${StringArray[@]}"; do
    cp ~/.dotfiles/$DOTFOLDER ~/.config/
done

#Excellent references
# https://www.chrisatmachine.com/Neovim/02-vim-general-settings/
# https://www.chrisatmachine.com/Neovim/01-vim-plug/

# nvim to install all the plugins
nvim +'PlugInstall --sync' +qa
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => leaving the instance (reboot necessary)
# -----------------------------------------------------------------------------

echo -e '\n=> Installation complete, rebooting the server this may take a minute'
sleep 5

}

function afterReboot() {
cd ~
echo '------------------------------------------------------------------------'
echo '=> Ubuntu 20.04LTS post-install script'
echo '=> Post reboot'
echo '------------------------------------------------------------------------'

sudo apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions 
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

}

# https://unix.stackexchange.com/questions/145294/how-to-continue-a-script-after-it-reboots-the-machine
# https://www.jamescoyle.net/cheat-sheets/791-update-rc-d-cheat-sheet
if [ -f /var/run/rebooting-for-updates ]; then
    afterReboot
    rm /var/run/rebooting-for-updates
    sudo update-rc.d UbuntuPostInstall.sh remove
    # deleting the file itself
    rm /etc/init.d/UbuntuPostInstall.sh
else
    beforeReboot
    touch /var/run/rebooting-for-updates
    sudo update-rc.d UbuntuPostInstall.sh defaults
    sudo reboot
fi
