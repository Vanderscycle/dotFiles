
#!/bin/bash
# Manjaro post-install script

cd ~
echo '------------------------------------------------------------------------'
echo '=> Manjaro 20.04LTS post-install script'
echo '=> Before reboot'
echo '------------------------------------------------------------------------'


echo -e '\n=> Update repository information'
# -S: synchronize your system's packages with those in the official repo
# -y: download fresh package databases from the server
# -u: upgrade all installed packages (like rsync)
# --noconfirm
echo -e '=> Perform system upgrade'
sudo pacman -Syu
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Install system utilities
# -----------------------------------------------------------------------------

echo -e '\n=> Installing system utilities'
echo -e 'Installing AUR helper (yay)'
# Arch User Repository (AUR) helper helps with the installation of packages from the AUR.
mkdir ~/Programs/
git clone https://aur.archlinux.org/yay.git ~/Programs/yay/ #Aur helper
cd ~/Programs/yay/ && makepkg -si --noconfirm --needed

echo -e 'Installing Nvidia drivers'
sudo pacman -S --noconfirm nvidia nvidia-utils    # NVIDIA 
echo -e 'Installing process managers (htop/gotop)'
yay -S --noconfirm gotop-bin htop
echo -e 'Done.\n'


# -----------------------------------------------------------------------------
# => Install developer packages
# -----------------------------------------------------------------------------

echo -e '\n=> Installing developer packages'
sudo pacman -S --noconfirm rsync git fzf
# for zsh alt+c (cd into fzf folders)
# ctrl+t (?) 
# ctrl+r(history)
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Docker
# -----------------------------------------------------------------------------

echo -e 'Installing Docker'
sudo pacman -S --noconfirm Docker
# https://wiki.archlinux.org/index.php/Docker
# https://docs.docker.com/config/daemon/
# touch /etc/docker/daemon.json # for specific user config
sudo systemctl start docker
sudo systemctl enable docker # allows it to start on start
sudo systemctl status docker # visual confirmation

echo -e 'Installing Docker compose'
sudo pacman -S --noconfirm docker-compose

echo -e 'Removing Sudo requirements'
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Font
# -----------------------------------------------------------------------------

echo -e 'Downloading Nerdfont'
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "JetBrains Mono Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/NoLigatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete.ttf
curl -fLo "JetBrains Mono Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/NoLigatures/Italic/complete/JetBrains%20Mono%20Italic%20Nerd%20Font%20Complete.ttf
curl -fLo "JetBrains Mono Bold Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/NoLigatures/Bold/complete/JetBrains%20Mono%20Bold%20Nerd%20Font%20Complete.ttf
curl -fLo "JetBrains Mono Bold Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/NoLigatures/BoldItalic/complete/JetBrains%20Mono%20NL%20Bold%20Italic%20Nerd%20Font%20Complete.ttf
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Terminal specific
# -----------------------------------------------------------------------------

echo -e 'Installing Alacritty'
sudo pacman -S alacritty
mkdir -p ~/.config/alacritty
touch  ~/.config/alacritty/alacritty.yml
# need to add the relevant files
# https://www.chrisatmachine.com/Linux/06-alacritty/ 
echo -e 'Done.\n'

echo -e 'Installing Tmux'
sudo pacman -S --noconfirm tmux
echo -e 'Done.\n'

echo -e '> Installing zsh and oh-my-zsh'
#https://medium.com/tech-notes-and-geek-stuff/install-zsh-on-arch-linux-manjaro-and-make-it-your-default-shell-b0098b756a7a
sudo pacman -S --noconfirm zsh
# changing the default from bash to zsh
sudo usermod -s /bin/zsh ${USER} 
sudo chsh -s $(which zsh) ${USER} 

# installing oh-my-zsh
#https://github.com/ohmyzsh/ohmyzsh/issues/5873#issuecomment-498678076
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

#zplug
curl -sL --proto-redir -all https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
#git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo -e '\nConfiguring the settings in .zshrc'
CONFIG=".zshrc"

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
export FZF_DEFAULT_COMMAND='fdfind --type f'
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --height=80%"
export PATH="$PATH:$HOME/miniconda3/bin"
EOF
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Miniconda
# -----------------------------------------------------------------------------

echo -e 'Installing Miniconda'
yay -S --noconfirm miniconda3

echo -e 'Configuring python env with basic package'
conda init zsh
conda create -y -n dev-branch python
conda activate dev-branch
conda install -y pandas numpy django 
pip3 install pynvim # required for neovim
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => NeoVim
# -----------------------------------------------------------------------------

echo -e 'Installing Text Editior (neovim)'
git clone https://aur.archlinux.org/neovim-nightly-bin.git ~/Programs/neovim/ 
cd ~/Programs/neovim/ && makepkg -si --noconfirm --needed

echo -e 'n\=> Configuring Neovim'
# fd alternative to find
# ueberzug allows for image display in terminal
yay -S --noconfirm python-ueberzug-git ripgrep-all fd
git clone https://github.com/siduck76/neovim-dots.git ~/Documents/
cd ~/Documents/neovim-dots && chmod +x install.sh && bash install.sh 

echo -e '\ninstalling enhancd using zplug'
zplug "b4b4r07/enhancd", use:init.sh

echo -e '\n adding fzf completion'
# source of info https://doronbehar.com/articles/ZSH-FZF-completion/
mkdir /usr/share/fzf/
touch /usr/share/fzf/completion.zsh
wget -O /usr/share/fzf/completion.zsh https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
touch /usr/share/fzf/key-bindings.zsh
wget -O /usr/share/fzf/key-bindings.zsh https://raw.githubusercontent.com/junegunn/fzf/d4ed955aee08a1c2ceb64e562ab4a88bdc9af8f0/shell/key-bindings.zsh
echo -e 'Done.\n'
# -----------------------------------------------------------------------------
# => Dotfiles
# -----------------------------------------------------------------------------

echo -e 'Importing dotfiles'
git clone --recursive https://github.com/Vanderscycle/ubuntu-dot-config ~/Documents/dotFiles
cd ~/Documents/dotFiles/ 
declare -a StringArray=( ".gitconfig" ".tmux.conf")
for DOTFILE in "${StringArray[@]}"; do
    # can't use symbolic link since we want the file
    if [ -f $DOTFILE ]
    then
        ln  ~/.dotfiles/$DOTFILE ~/$DOTFILE
    fi
done
# -----------------------------------------------------------------------------
# => Databases
# -----------------------------------------------------------------------------

echo -e 'Installing Postgresql'
# https://lobotuerto.com/blog/how-to-install-postgresql-in-manjaro-linux/
yay -S --noconfirm postgresql postgis

echo -e 'Configuring Postgresql'
# need to pass commands directly investigate
sudo su postgres -l # or sudo -u postgres -i
initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data/'
exit

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

# -----------------------------------------------------------------------------
# => Local application (local machine only)
# -----------------------------------------------------------------------------

echo '\n=> Installing local machine applications'
echo -e 'Installing Torrent client (Transmission)'
# more investigation required
git clone https://aur.archlinux.org/transmission-cli-git.git ~/Programs/transmission/
cd ~/Programs/transmission/ && makepkg -si --noconfirm --needed

echo -e 'Installing Window manager (bspwm)' # what a pain 
sudo pacman -S --noconfirm xorg xorg-xinit bspwm sxhkd dmenu nitrogen picom arandr
#sxhkd for keybindings
#arandr fo rmultple screens
mkdir ~/.config/bspwm/
mkdir ~/.config/sxhkd/
cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/
cp /etc/X11/xinit/xinitrc ~/.xinitrc

cat >> ~/.xinitrc << EOF
sextkbmap ch &
picom -f &
exec bspwm
EOF

CONFIG="/etc/xdg/picom.conf"
if grep -Fq "vsync = true" $CONFIG
then
    OLD="'vsync = true'"
    NEW="'#vsync = true'"
    sed -i "s%$OLD%$NEW%g" $CONFIG
fi


sudo touch /etc/X11/Xwrapper.config
sudo cat >> /etc/X11/Xwrapper.config << EOF
allowed_users = anybody
needs_root_rights = no
EOF

echo -e 'Installing remote working software (zoom/discord)'
yay -S --noconfirm zoom
yay -S --noconfirm discord

echo -e 'Installing entertainment (steam/spotify)'
yay -S --noconfirm ncspot #command line client for spotify (may want to move to Ncmpcpp later)
yay -S --noconfirm vlc

echo -e 'Installing web browser'
yay -S --noconfirm brave
