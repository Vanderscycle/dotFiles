#!/bin/bash
# Manjaro post-install script

function beforeReboot() {

cd ~
echo '------------------------------------------------------------------------'
echo '=> Manjaro 20.04LTS post-install script'
echo '=> Before reboot'
echo '------------------------------------------------------------------------'

echo -e '\n=> Update repository information'
# -S: synchronize your system's packages with those in the official repo
# -y: download fresh package databases from the serverrm
echo -e '=> Perform system upgrade'
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel git
# not sure why this format works
sudo -- sh -c "echo Defaults env_reset,timestamp_timeout=300 >> /etc/sudoers"
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Install system utilities
# -----------------------------------------------------------------------------

echo -e '\n=> Installing system utilities'
echo -e 'Installing AUR helper (yay)'
# Arch User Repository (AUR) helper helps with the installation of packages from the AUR.
#https://averagelinuxuser.com/which-aur-helper-yay/
mkdir -p ~/Programs/
#git clone https://aur.archlinux.org/yay.git ~/Programs/yay/ #Aur helper
#cd ~/Programs/yay/ && makepkg -si --noconfirm --needed
sudo pacman -S --noconfirm --needed yay
sudo pacman -S --noconfirm --needed xclip unzip

echo -e 'Installing Nvidia drivers'
sudo pacman -S --noconfirm --needed nvidia nvidia-utils    # NVIDIA 
echo -e 'Installing process managers (htop/gotop)'
sudo pacman -S --noconfirm --needed nodejs
yay -S --noconfirm gotop-bin htop
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Install developer packages
# -----------------------------------------------------------------------------

echo -e '\n=> Installing developer packages'
sudo pacman -S --noconfirm rsync git fzf
# corrector for bash scripts
sudo pacman -S --noconfirm shellcheck # maybe bloat?
#shellcheck (bash file)
# for zsh alt+c (cd into fzf folders)
# ctrl+t (?) 
# ctrl+r(history)
echo 'Installing npm and lsp(nvim)'
#typescript (global with language client)
sudo npm install -g typescript typescript-language-server diagnostic-languageserver eslint_d prettier
sudo npm install -g pyright
sudo npm install -g dockerfile-language-server-nodejs #https://github.com/rcjsuen/dockerfile-language-server-nodejs#installation-instructions
sudo npm install -g tldr
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => ZSH
# -----------------------------------------------------------------------------

echo -e '\n=> Installing zsh'
#https://medium.com/tech-notes-and-geek-stuff/install-zsh-on-arch-linux-manjaro-and-make-it-your-default-shell-b0098b756a7a
sudo pacman -S --noconfirm zsh
# changing the default from bash to zsh
sudo usermod -s /bin/zsh ${USER} 
sudo chsh -s $(which zsh) ${USER} 

# -----------------------------------------------------------------------------
# => Miniconda 
# -----------------------------------------------------------------------------

echo -e '\n=> Installing Miniconda'
cd ~
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b
export PATH=~/miniconda3/bin:$PATH
conda init zsh
rm Miniconda3-latest-Linux-x86_64.sh # clean the install
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Docker
# -----------------------------------------------------------------------------

echo -e '\n=> Installing Docker'
sudo pacman -S --noconfirm --needed Docker
# https://wiki.archlinux.org/index.php/Docker
# https://docs.docker.com/config/daemon/
# touch /etc/docker/daemon.json # for specific user config
sudo systemctl start docker
sudo systemctl enable docker # allows it to start on start
sudo systemctl status docker # visual confirmation

echo -e '\n=> Installing Docker compose'
sudo pacman -S --noconfirm docker-compose

echo -e 'Removing Sudo requirements'
sudo groupadd docker
sudo usermod -aG docker ${USER}
echo -e 'Done.\n'

}

function afterReboot() {

cd ~
echo '------------------------------------------------------------------------'
echo '=> Manjaro 20.04LTS post-install script'
echo '=> After reboot'
echo '------------------------------------------------------------------------'

# -----------------------------------------------------------------------------
# => Terminal specific
# -----------------------------------------------------------------------------

echo -e '\n=> Installing Alacritty'
sudo pacman -S --noconfirm alacritty
mkdir -p ~/.config/alacritty
touch  ~/.config/alacritty/alacritty.yml
# need to add the relevant files
# https://www.chrisatmachine.com/Linux/06-alacritty/ 
echo -e 'Done.\n'

echo -e '\n=> Installing Tmux and tmuxinator'
sudo pacman -S --noconfirm tmux
yay -S --noconfirm --needed tmuxinator
#gem install tmuxinator #(alternate way)
echo -e 'Done.\n'

echo -e '\n=> Installing oh-my-zsh'

# installing oh-my-zsh
#https://github.com/ohmyzsh/ohmyzsh/issues/5873#issuecomment-498678076
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
rm ~/.zshrc.pre-oh-my-zsh
#zplug
curl -sL --proto-redir -all https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
#git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo -e '\ninstalling enhancd using zplug'
zplug "b4b4r07/enhancd", use:init.sh #! doesn't work

echo -e '\nadding fzf completion'
# source of info https://doronbehar.com/articles/ZSH-FZF-completion/
mkdir /usr/share/fzf/
sudo touch /usr/share/fzf/completion.zsh
sudo wget -O /usr/share/fzf/completion.zsh https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
sudo touch /usr/share/fzf/key-bindings.zsh
sudo wget -O /usr/share/fzf/key-bindings.zsh https://raw.githubusercontent.com/junegunn/fzf/d4ed955aee08a1c2ceb64e562ab4a88bdc9af8f0/shell/key-bindings.zsh
echo -e 'Done.\n'

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo -e '\nConfiguring the settings in .zshrc'
CONFIG=".zshrc"

if grep -Fq "plugins" $CONFIG
then
        OLD="plugins=(git)"
        read -d '' NEW << EOF
        plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting tmuxinator)
        export FZF_BASE=/usr/bin/fzf
        export FZF_DEFAULT_COMMAND='rg'
        EOF
        sed -i "s%$OLD%$NEW%g" $CONFIG
fi
if grep -Fq "ZSH_THEME" $CONFIG
then
        OLD='ZSH_THEME="robbyrussell"'
        NEW='#ZSH_THEME="robbyrussell"'
        sed -i "s%$OLD%$NEW%g" $CONFIG
fi

#conda and zplug line
cat >> $CONFIG << EOF
# Use powerline
USE_POWERLINE="true"

# Source manjaro-zsh-configuration(theme)
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi

# Use manjaro zsh prompt(theme)
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

#zplug addition
if [ -f ${HOME}/.zplug/init.zsh ]; then
    source ${HOME}/.zplug/init.zsh
fi

# vim keys
set -o vi
# to exit terminal in nvim
alias :q=exit

export FZF_DEFAULT_COMMAND='fdfind --type f'
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --height=80%"
export PATH="$PATH:$HOME/miniconda3/bin"
EOF

echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Miniconda (env cont)
# -----------------------------------------------------------------------------

echo -e '\n=> Configuring python env with basic package through Conda'
conda create -y -n dev-branch python
conda activate dev-branch 
conda install -y pandas numpy django 
pip3 install pynvim # required to work with nvim


conda create -y -n machine-learning python pandas numpy 
conda activate machine-learning
pip3 install pynvim # required to work with nvim
conda install -c conda-forge scikit-learn
#conda install pytorch torchvision torchaudio cudatoolkit=11.1 -c pytorch -c conda-forge # pytoch ml library
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => NeoVim
# -----------------------------------------------------------------------------

echo -e 'Installing Text Editior (neovim)'
git clone https://aur.archlinux.org/neovim-nightly-bin.git ~/Programs/neovim/ 
cd ~/Programs/neovim/ && makepkg -si --noconfirm --needed

echo -e 'Configuring Neovim'
# fd alternative to find
# ueberzug allows for image display in terminal
yay -S --noconfirm python-ueberzug-git ripgrep-all fd
git clone https://github.com/siduck76/chad-nvim.git ~/Documents/neovim-dots
cd ~/Documents/neovim-dots && chmod +x install.sh && bash install.sh 
export EDITOR='nvim' >> ~/.zshrc
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Security (ssh)
# -----------------------------------------------------------------------------

echo -e 'Configuring SSH'
# https://pandammonium.org/how-to-change-a-git-repository-from-https-to-ssh/
mkdir ~/.ssh/
cd ~/.ssh/ && ssh-keygen -t ed25519 -C "hvandersleyen@gmail.com" -f manajaoGit -N ""
eval $(ssh-agent)
ssh-add  ~/.ssh/manjaroGit
# the rest has to be done manually (add the pub file to git)

#because everytime you open a new terminal you need to create an agent id
echo -e 'Installing password manager (pass)'
sudo pacman -S --needed --noconfirm pass gnupg keychain
# https://www.gnupg.org/documentation/manuals/gnupg/Agent-OPTION.html
mkdir ~/.gnupg/
touch ~/.gnupg/gpg.conf
touch ~/.gnupg/gpg-agent.conf
# https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e
echo 'use-agent' >> ~/.gnupg/gpg.conf
echo 'pinentry-mode loopback' >> ~/.gnupg/gpg.conf

#echo "pinentry-mode loopback" >> ~/.gnupg/gpg.conf
# https://github.com/tpope/vim-fugitive/issues/782
# https://github.com/tpope/vim-fugitive/issues/846 #(to enable tpope/dispatch working)

chmod 700 ~/.gnupg
# need to manually configure the gpg key
#eval $(ssh-agent)
#ssh-add  ~/.ssh/manjaroGit
#echo RELOADAGENT | gpg-connect-agent
#echo "test" | gpg2 --clearsign

echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Dotfiles
# -----------------------------------------------------------------------------

echo -e 'Importing dotfiles'
git clone --recursive https://github.com/Vanderscycle/ubuntu-dot-config ~/Documents/dotFiles/

chmod +x ~/Documents/dotFiles/stdPatterns/sshkeychain.sh
chmod +x ~/Documents/dotFiles/stdPatterns/baseNvimConfigUpdate.sh

# to test usin -d
rsync -auvd ~/Documents/dotFiles/nvim/ ~/.config/nvim/ 

echo "Installing vimspector manually"
git clone https://github.com/puremourning/vimspector ~/.loca/nvim/site/pack/packer/opt/vimspector
#updating nvim from siduck76 with my changes (plugins/mappings etc)
#bash ~/Documents/dotFiles/stdPatterns/baseNvimConfigUpdate.sh

cd ~/Documents/dotFiles/ 
declare -a StringArray=( ".gitconfig" ".tmux.conf" ".zprofile" ".zlogout" ".zshenv" ".zlogin")
for DOTFILE in "${StringArray[@]}"; do
    if [ -f $DOTFILE ]
    then
        rsync -auv ~/Documents/dotFiles/$DOTFILE ~/$DOTFILE
    fi
done
echo -e 'Importing alacritty dotfiles'
rsync -auv ~/Documents/dotFiles/alacritty.yml ~/.config/alacritty/alacritty.yml
rsync -auv ~/Documents/dotFiles/neomutt/ ~/.config/neomutt/ 
rsync -auv ~/Documents/dotFiles/vimwiki ~/vimwiki 
rsync -auv ~/Documents/dotFiles/tmuxinator/ ~/.config/tmuxinator/ 
git config --global init.defaultBranch main

# because my neovim config is based off someone's else config I need to be able to pull from theirs and then update.
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Font
# -----------------------------------------------------------------------------

echo -e 'Nerdfont'
mkdir -p ~/.local/share/fonts/ttf/
rsync -auv ~/Documents/dotFiles/NerdFonts/JetBrains/ ~/.local/share/fonts/ttf/
fc-cache -vf
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Databases
# -----------------------------------------------------------------------------

echo -e 'Installing Postgresql'
# https://lobotuerto.com/blog/how-to-install-postgresql-in-manjaro-linux/
yay -S --noconfirm postgresql postgis

echo -e 'Configuring Postgresql'
# need to pass commands directly investigate
#sudo su postgres -l # or sudo -u postgres -i
#initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data/'
#exit
echo -e 'Done.\n'

sudo systemctl start postgresql
sudo systemctl enable postgresql # allows it to start on start
sudo systemctl status postgresql # visual confirmation

echo -e 'Installing Mongo'
git clone https://aur.archlinux.org/mongodb-bin.git ~/Programs/mongo/
cd ~/Programs/mongo/ && makepkg -si --noconfirm --needed

echo -e 'Configuring Mongo'
sudo systemctl start mongodb
sudo systemctl enable mongodb # allows it to start on start
sudo systemctl status mongodb # visual confirmation
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Local application (local machine only)
# -----------------------------------------------------------------------------

echo '\n=> Installing local machine applications'
echo -e 'Installing Torrent client (Transmission)'
# more investigation required
#git clone https://aur.archlinux.org/transmission-cli-git.git ~/Programs/transmission/
#cd ~/Programs/transmission/ && makepkg -si --noconfirm --needed

echo -e 'Installing remote working software (zoom/discord)'
yay -S --noconfirm zoom discord

echo -e 'Installing libreOffice'
pacman -S --noconfirm --needed libreoffice

echo -e 'Installing entertainment (steam/spotify)'
yay -S --noconfirm vlc #command line client for spotify (may want to move to Ncmpcpp later)
# https://wvarner.blogspot.com/2017/10/setting-up-mopidy-ncmpcpp-and-spotify.html (config)
sudo pacman -S --noconfirm mopidy 
yay -S --noconfirm ncmpcpp mopidy-mpd mopidy-spotify mpd # mopidy extensions like spotify
# to access you need to use ncmpcpp in the terminal

echo -e 'configuring mpd'
mkdir -p ~/.config/mpd
touch ~/.config/mpd/conf
cat >> ~/.config/mpd/conf <<EOF
port "6600"
EOF

echo -e 'configuring ncmpcpp'
# https://pkgbuild.com/~jelle/ncmpcpp/
mkdir -p ~/.config/ncmpcpp/
touch ~/.config/ncmpcpp/conf
cat >> ~/.config/ncmpcpp/conf <<EOF
mpd_host = "127.0.0.1"
mpd_port = 6600
mpd_music_dir = ~/Music
EOF

echo -e 'configuring mopidy'
#https://blog.deepjyoti30.dev/using-spotify-with-ncmpcpp-mopidy-linux
mkdir -p ~/.config/mopidy
touch ~/.config/mopidy/mopidy.conf
cat >> ~/.config/mopidy/mopidy.conf <<EOF
[core]
restore_state = true

[mpd]
enabled = true
hostname = 127.0.0.1
port = 6600

[spotify]
enabled = true
username = your_username
password = your_pw
client_id = your_client_id
client_secret = your_client_secret
bitrate = 320
EOF
echo -e 'Installing web browser'
yay -S --noconfirm brave

echo -e 'Installing emoji for browser support'
pacman -S --noconfirm noto-fonts-emoji

echo -e 'Installing neomutt for terminal email support'
#https://unix.stackexchange.com/questions/172666/gmail-blocking-mutt
sudo pacman -S --noconfirm neomutt
mkdir -p ~/.mutt/cache/bodies/

}

if [ -f /var/run/rebooting-for-updates ]; then

    
    sudo rm /var/run/rebooting-for-updates
    sudo update-rc.d Manjaro-Arch-temp.sh remove
    touch ~/postInstallLog.txt
    afterReboot >> ~/postInstallLog.txt
    # deleting the file itself
    rm /etc/init.d/Manjaro-Arch-temp.sh
    
else
    
    sudo touch /var/run/rebooting-for-updates
    sudo update-rc.d Manjaro-Arch-temp.sh defaults
    touch ~/preInstallLog.txt
    beforeReboot >> ~/preInstallLog.txt
    sudo reboot
fi
# todo
# xmonad # https://wiki.manjaro.org/index.php/Install_Desktop_Environments#Tiling_Window_Managers
# french and chinese language/keyboards packs # https://wiki.manjaro.org/index.php?title=Locale
# slack
