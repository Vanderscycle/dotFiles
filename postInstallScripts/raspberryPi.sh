#!/bin/bash

function beforeReboot(){
echo '------------------------------------------------------------------------'
echo '=> Raspbian post-install script'
echo '=> Post reboot'
echo '------------------------------------------------------------------------'

# -----------------------------------------------------------------------------
# => User creation
# -----------------------------------------------------------------------------
echo -e '\n=> User creation'
#grainting the sudo
sudo usermod -aG sudo pi
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
# cmake used to compile a tmux plugin
# -----------------------------------------------------------------------------

echo -e '\n=> Install developer packages'
sudo apt-get install -y --no-install-recommends git neovim python3-pip expect tmux rsync cmake
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
# should look at using pyenv
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
# => Tracker/malware and bloatware blocker
# -----------------------------------------------------------------------------
echo '\n=> Internet security'
echo '=> Do you want to append a blocked list to /etc/hosts? [Y/n]'
read confirmation
confirmation=$(echo $confirmation | tr '[:lower:]' '[:upper:]')
if [[ $confirmation == 'YES' || $confirmation == 'Y' ]]; then
    curl --silent --show-error https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts | sudo tee -a /etc/hosts
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
echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >> ~/.zshrc
cat >> $CONFIG << EOF
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -f ${HOME}/.zplug/init.zsh ]; then
    source ${HOME}/.zplug/init.zsh
fi

EOF
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
cd ~/.dotfiles/ # Not sure why it works this way but I am a bit tired
declare -a StringArray=( ".gitconfig" ".p10k.zsh" ".tmux.conf")
for DOTFILE in "${StringArray[@]}"; do
    # can't use symbolic link since we want the file
    if [ -f $DOTFILE ]
    then
        ln  ~/.dotfiles/$DOTFILE ~/$DOTFILE
    fi
done
cd ~

echo -e 'Moving NVim files to ~/.config/ \n'
# folders
mkdir .config/
declare -a StringArray=("nvim")
# Copying all the folders for neovim
for DOTFOLDER in "${StringArray[@]}"; do
    cp -r ~/.dotfiles/$DOTFOLDER ~/.config/ # do not forget -r (recursive for folders)
done

# Installing vim-gitgutter
echo -e 'Installing vim-gitgutter(no Vim plug)\n'
mkdir -p ~/.config/nvim/pack/airblade/start
cd ~/.config/nvim/pack/airblade/start
git clone https://github.com/airblade/vim-gitgutter.git
nvim -u NONE -c "helptags vim-gitgutter/doc" -c q

# Installing Vim Calendar
mkdir -p ~/.cache/calendar.vim/ && touch ~/.cache/calendar.vim/credentials.vim
chmod 700 ~/.cache/calendar.vim && chmod 600 ~/.cache/calendar.vim/credentials.vim
cat >> ~/.cache/calendar.vim/credentials.vim << EOF
let g:calendar_google_api_key = '...'
let g:calendar_google_client_id = '....apps.googleusercontent.com'
let g:calendar_google_client_secret = '...'
EOF
#Excellent references
# https://www.chrisatmachine.com/Neovim/02-vim-general-settings/
# https://www.chrisatmachine.com/Neovim/01-vim-plug/

# nvim to install all the plugins
nvim +'PlugInstall --sync' +qa
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Installing NerdFonts
# -----------------------------------------------------------------------------
echo '=> Fetching and installing nerdfont'
mkdir -p ~/.local/share/fonts/NerdFonts/Meslo/
rsync ~/.dotfiles/NerdFonts ~/.local/share/fonts/NerdFonts/Meslo/

echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Installing alacritty
# -----------------------------------------------------------------------------
echo '=> Installing alacritty'

echo 'Changing the font of the terminal'
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Tmux
# installation of TPM handled through .tmux.config file
# need cmake to install load
# -----------------------------------------------------------------------------

echo -e '=> Installing Tmux'
cd ~/.tmux/plugins/tmux-mem-cpu-load/
cmake .
make
echo -e 'Done.\n'
# -----------------------------------------------------------------------------
# => leaving the instance (reboot necessary)
# -----------------------------------------------------------------------------

echo -e '\n=> Installation complete, rebooting the server this may take a minute'
sleep 5
}


function afterReboot() {
echo '------------------------------------------------------------------------'
echo '=> raspbian post-install script'
echo '=> Post reboot'
echo '------------------------------------------------------------------------'

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
}

if [ -f /var/run/rebooting-for-updates ]; then
    afterReboot
    rm /var/run/rebooting-for-updates
    sudo update-rc.d raspberryPi.sh remove
    # deleting the file itself
    rm /etc/init.d/UbuntuPostInstall.sh
else
    beforeReboot
    touch /var/run/rebooting-for-updates
    sudo update-rc.d raspberryPi.sh defaults
    sudo reboot
fi
