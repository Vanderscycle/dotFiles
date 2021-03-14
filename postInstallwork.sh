#!/bin/bash
# example https://gist.github.com/rougeth/8108714
# wget https://raw.githubusercontent.com/Vanderscycle/ubuntu-dot-config/main/postInstallwork.sh && chmod +x postInstallwork.sh && bash postInstallwork.sh
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
sudo apt-get install -y --no-install-recommends git neovim python3-pip
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
echo e'\n=> Installing Docker-compose' 
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Miniconda
# -----------------------------------------------------------------------------

echo '=> Installing Conda'
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
spawn ./Miniconda3-latest-Linux-x86_64.sh
expect "enter"
send '\r'
expect 'yes|no'
send 'yes'
interact
conda create -n base python
conda install pandas numpy django
rm Miniconda3-latest-Linux-x86_64.sh
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Databases
# -----------------------------------------------------------------------------

echo -e '\n=> Installing Postgres'
sudo apt-get install -y --no-install-recommends postgresql postgresql-contrib
echo '=> Starting Postgres'
sudo systemctl enable postgresql
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
echo -e '\n=> Installing zsh and theme'
sudo apt-get install -y --no-install-recommends zsh
# changing the default from bash to zsh
chsh -s $(which zsh) -y
# installing oh-my-zsh
spawn  sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
expect "Y/n" {send -- "y\r"}
interact
exit
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Get dotfiles
# -----------------------------------------------------------------------------
echo '=> Get dotfiles (https://github.com/Vanderscycle/ubuntu-dot-config)'

# Create a tmp folder with random name
dotfiles_path="`(mktemp -d)`"

# Clone the repository recursively
git clone --recursive https://github.com/Vanderscycle/ubuntu-dot-config "$dotfiles_path"
cd "$dotfiles_path"

# Copy all dotfiles except .git/ and .gitmodules
cp -r `ls -d .??* | egrep -v '(.git$|.gitmodules)'` $HOME

echo -e 'Done.\n'



# -----------------------------------------------------------------------------
# => leaving the instance (reboot necessary)
# -----------------------------------------------------------------------------

echo -e '\n=> Installation complete please relog'
sleep 5
exit