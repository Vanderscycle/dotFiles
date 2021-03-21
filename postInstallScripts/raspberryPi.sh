#!/bin/bash
echo '------------------------------------------------------------------------'
echo '=> Raspbian post-install script'
echo '------------------------------------------------------------------------'

# -----------------------------------------------------------------------------
# => General update
# -----------------------------------------------------------------------------
echo -e '\n=> User creation'
#grainting the sudo
sudo usermod -aG sudo pi
echo -e 'Done.\n'
# -----------------------------------------------------------------------------
# => General update
# -----------------------------------------------------------------------------

echo -e '\n=> Update repository information'
sudo apt-get update -qq #-qq for quiet
echo -e '=> Perform system upgrade'
sudo apt-get dist-upgrade -y
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Install system utilities
# fontconfig fbterm (for font   )
# -----------------------------------------------------------------------------

echo -e '\n=> Install system utilities'
sudo apt-get install -y --no-install-recommends curl wget git lsof gdebi-core fontconfig fbterm\
    zip unzip gzip tar \
    ssh
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Install developer packages
# python 3 not installed by default
# -----------------------------------------------------------------------------

echo -e '\n=> Install developer packages'
sudo apt-get install -y --no-install-recommends git neovim \
    libffi-dev libssl-dev \
    python3 python3-dev python3-pip \
    expect
echo -e 'Done.\n'
# -----------------------------------------------------------------------------
# => Miniconda
# Doesn't support arm processors only Amd and intel 
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# => Docker (debian)
# Doesn't work with Pi  Zero (armv6)
# https://pumpingco.de/blog/setup-your-raspberry-pi-for-docker-and-docker-compose/
# -----------------------------------------------------------------------------

echo '=> Removing old docker version (if present) Docker' 
sudo apt-get purge docker-ce
echo -e'\n=> Installing Docker' 
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
docker version
echo -e'\n=> Removing Sudo requirement Docker' 
sudo usermod -aG docker ${USER}
echo -e'\n=> Installing Docker-compose' 
sudo pip3 install docker-compose #have to use python 3
echo '=> Removing docker installation file' 
rm get-docker.sh
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
# => Install Terminal Specific
# helpful reference for sed https://core-electronics.com.au/tutorials/create-an-installer-script-for-raspberry-pi.html
# -----------------------------------------------------------------------------
echo -e '\n=> Installing zsh and pk10 theme'
sudo apt-get install -y --no-install-recommends zsh
sudo chsh -s $(which zsh)
echo -e '\n=> Installing oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo -e '\nCloning relevant github zsh repo: 10k, zplug, autosuggestion and syntax highlight'
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# adding 2 usefull pluging
sudo git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions 
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

echo -e '\ninstalling Fira Mono Nerd Font'
# wget https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/install.sh && chmod +x install.sh && bash install.sh
mkdir .fonts
wget -o .fonts/FiraMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraMono.zip && unzip FiraMono.zip -d .fonts && rm FiraMono.zip && fc-cache -v -f
#sudo dpkg-reconfigure console-setup

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
#! need to do a find all .
declare -a StringArray=( ".gitconfig" ".vimrc" ".p10k.zsh" ".alias")
for DOTFILE in "${StringArray[@]}"; do
    # can't use symbolic link since we want the file
    ln  ~/.dotfiles/$DOTFILE ~/$DOTFILE
done

echo -e 'Done.\n'
# -----------------------------------------------------------------------------
# => reboot
# -----------------------------------------------------------------------------

sudo shutdown -r now