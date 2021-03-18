#!/bin/bash
# example https://gist.github.com/rougeth/8108714
# wget https://raw.githubusercontent.com/Vanderscycle/ubuntu-dot-config/main/UbuntuPostInstall.sh && chmod +x UbuntuPostInstall.sh && bash UbuntuPostInstall.sh
# Ubuntu post-install script
echo '------------------------------------------------------------------------'
echo '=> Ubuntu 20.04LTS post-install script'
echo '------------------------------------------------------------------------'


echo -e '\n=> Update repository information '
sudo apt-get update -qq #-qq for quiet
echo -e '=> Perform system upgrade'
sudo apt-get dist-upgrade -y
echo -e 'Done.\n'
# -----------------------------------------------------------------------------
# => Install system utilities
# -----------------------------------------------------------------------------

echo -e '\n=> Install system utilities'
sudo apt-get install -y --no-install-recommends curl wget git lsof gdebi-core \
    zip unzip gzip tar \
    ssh
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

echo '=> Removing old docker version (if present) Docker' 
sudo apt-get remove -y docker docker-engine docker.io containerd runc
echo -e'\n=> Installing Docker' 
sudo apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io
apt-cache madison docker-ce
sudo apt-get install docker-ce=5:20.10.5~3-0~ubuntu-bionic docker-ce-cli=5:20.10.5~3-0~ubuntu-bionic containerd.io
echo -e'\n=> Removing Sudo requirement Docker' 
sudo usermod -aG docker ${USER}
echo -e'\n=> Enabling Docker to start upon boot' 
sudo systemctl enable docker
sudo systemctl start docker
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
# -----------------------------------------------------------------------------

echo -e '\n=> Installing Postgres'
sudo apt-get install -y --no-install-recommends postgresql postgresql-contrib
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
    snap install spotify discord mailspring discord
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
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions 
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

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
cat >> $CONFIG << EOF
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
# need to find a more automatic way to do this
ln -s ~/.doftiles/.p10k.zsh ~/.p10k.zsh
ln -s ~/.doftiles/.vimrc ~/.vimrc
ln -s ~/.doftiles/.gitconfig ~/.gitconfig
echo -e 'Done.\n'



# -----------------------------------------------------------------------------
# => leaving the instance (reboot necessary)
# -----------------------------------------------------------------------------

echo -e '\n=> Installation complete, rebooting the server this may take a minute'
sleep 5
rm UbuntuPostInstall.sh
sudo shutdown -r now