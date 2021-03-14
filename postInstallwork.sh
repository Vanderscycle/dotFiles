#!/bin/bash
# example https://gist.github.com/rougeth/8108714
# Ubuntu post-install script
echo '------------------------------------------------------------------------'
echo '=> Ubuntu 20.04LTS post-install script'
echo '------------------------------------------------------------------------'


echo '=> Update repository information'
sudo apt-get update -qq #-qq for quiet
echo '=> Performe system upgrade'
sudo apt-get dist-upgrade -y
echo 'Done.'
# -----------------------------------------------------------------------------
# => Install system utilities
# -----------------------------------------------------------------------------

echo '=> Install system utilities'
sudo apt-get install -y --no-install-recommends curl wget git lsof gdebi-core \
    zip unzip gzip tar \
    ssh
echo 'Done.'
# -----------------------------------------------------------------------------
# => Install Terminal Specific
# -----------------------------------------------------------------------------
echo '=> Installing zsh and theme'
sudo apt-get install -y --no-install-recommends zsh
# changing the default from bash to zsh
chsh -s $(which zsh) 
# installing oh-my-zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
echo 'Done.'

# -----------------------------------------------------------------------------
# => Install developer packages
# -----------------------------------------------------------------------------

echo '=> Install developer packages'
sudo apt-get install -y --no-install-recommends git neovim python3-pip
echo 'Done.'

# -----------------------------------------------------------------------------
# => Docker (debian)
# https://docs.docker.com/engine/install/debian/
# -----------------------------------------------------------------------------

echo '=> Removing old docker version (if present) Docker' 
sudo apt-get remove -y docker docker-engine docker.io containerd runc
echo '=> Installing Docker' 

sudo apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io
apt-cache madison docker-ce
sudo apt-get install docker-ce=5:20.10.5~3-0~ubuntu-bionic docker-ce-cli=5:20.10.5~3-0~ubuntu-bionic containerd.io
echo '=> Installing Docker-compose' 
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo 'Done.'

# -----------------------------------------------------------------------------
# => Miniconda
# -----------------------------------------------------------------------------

echo '=> Installing Conda'
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
bash Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh
conda create -n base python
conda install pandas numpy django
echo 'Done.'

# -----------------------------------------------------------------------------
# => Databases
# -----------------------------------------------------------------------------

echo '=> Installing Postgres'
sudo apt-get install -y --no-install-recommends postgresql postgresql-contrib
echo '=> Starting Postgres'
sudo systemctl enable postgresql
service postgresql start
echo '=> Installing MongoDb'
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update
sudo apt-get install -y --no-install-recommends mongodb-org
echo '=> Starting Mongo'
sudo systemctl enable mongod
sudo systemctl start mongod
echo 'Done.'

# -----------------------------------------------------------------------------
# => Security
# -----------------------------------------------------------------------------

echo '=> Configuring security'
mkdir -p ~/.ssh
sudo chmod 700 ~/.ssh/
sudo chmod 600 ~/.ssh/*
echo 'Done.'

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

echo 'Done.'


# -----------------------------------------------------------------------------
# => if local machine
# -----------------------------------------------------------------------------
echo '=> Install favorite applications'
echo '=> spotify discord mailspring vlc vscode gitkraken'
echo -e '=> Are you sure? [Y/n] '
read confirmation
confirmation=$(echo $confirmation | tr '[:lower:]' '[:upper:]')
if [[ $confirmation == 'YES' || $confirmation == 'Y' ]]; then

    sudo apt-get install -y --no-install-recommends vlc code
    snap install spotify discord mailspring discord
    wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
    sudo dpkg -i gitkraken-amd64.deb


    echo 'Done.'
fi