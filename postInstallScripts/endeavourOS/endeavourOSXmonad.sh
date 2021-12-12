# !/bin/bash

# sudo pacman -S --needed --noconfirm httpie wget && http  --download https://raw.githubusercontent.com/Vanderscycle/dot-config/main/postInstallScripts/endeavourOS/endeavourOSXmonad.sh && chmod +x ./endeavourOSXmonad.sh && bash ./endeavourOSXmonad.sh
cd ~
echo '------------------------------------------------------------------------'
echo '=> EndavorOs post-install script'
echo 'Current os version: Atantis'
echo 'wm: Xmonad w/ Xmobar'
echo '------------------------------------------------------------------------'

echo -e '\n=> Update repository information'
# -S: synchronize your system's packages with those in the official repo
# -y: download fresh package databases from the serverrm
echo -e '=> Perform system upgrade'
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel git 
echo 'cli download programs'
sudo pacman -S --needed --noconfirm httpie curl

sudo -- sh -c "echo Defaults env_reset,timestamp_timeout=300 >> /etc/sudoers"
echo -e 'Done.\n'

#INFO: configure ssh before using ssh
echo -e '\n=> importing our doots'
git clone https://github.com/Vanderscycle/dot-config.git ~/Documents/dotFiles/
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Install system utilities
# -----------------------------------------------------------------------------


echo -e '\n=> Installing system utilities'
echo -e 'Installing AUR helper (yay)'
sudo pacman -S --noconfirm --needed yay

echo '=>Rust and cargo'
# TODO: find a way to skip install (pass a 1)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install --branch main --git https://github.com/Kampfkarren/selene selene
cargo install stylua  
echo -e 'Done.\n'

echo 'installing c lang'
pacman -S clang
echo -e 'Done.\n'

#Python
echo -e '\n=> Installing Miniconda'
cd ~
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b
export PATH=~/miniconda3/bin:$PATH
conda init zsh
rm Miniconda3-latest-Linux-x86_64.sh # clean the install
echo -e 'Done.\n'

#JS/TS
echo -e 'Installing nodeJs'
sudo pacman -S --noconfirm --needed nodejs npm
yay -S --noconfirm  htop
echo -e 'Done.\n'

echo -e '\n=> Installing Kitty'
sudo pacman -S --noconfirm kitty
echo -e 'Done.\n'

echo -e '\n=> Installing Tmux and tmuxinator'
sudo pacman -S --noconfirm tmux
yay -S --noconfirm --needed tmuxinator
echo -e 'Done.\n'

echo -e '\n=> Installing systemctl moditor (fzf)'
yay -S --noconfirm --needed sysz

echo -e '\n=> Installing developer packages and useful tui alternatives'
sudo pacman -S --noconfirm rsync git fzf jq github-cli bat exa ripgrep lazygit htop unzip

echo -e '\n=> Installing zsh'
yay -Syu --noconfirm --needed zsh

#BUG: oh my zsh not working
echo -e '\n=> Installing oh-my-zsh'
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended

echo -e '\n=> Installing zsh/oh-my-zsh plugins'
sudo pacman -S  --noconfirm --needed zsh-syntax-highlighting  zsh-autosuggestions  
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/supercrabtree/k ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/k
#enhancd
mkdir -p ~/Programs/
git clone https://github.com/b4b4r07/enhancd ~/Programs/enhancd
 echo "source ~/Programs/enhancd/init.sh"  >> ~/.zprofile
source ~/.zshrc
chsh -s  $(which zsh)

#BUG: zplug not working at install
# echo -e '\n=> zplug'
# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
# echo -e '\ninstalling enhancd using zplug'
# zplug "b4b4r07/enhancd", use:init.sh #! doesn't work

echo -e '\adding fzf completion'
# source of info https://doronbehar.com/articles/ZSH-FZF-completion/
#mkdir /usr/share/fzf/ # file exists
sudo touch /usr/share/fzf/completion.zsh
sudo wget -O /usr/share/fzf/completion.zsh https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
sudo touch /usr/share/fzf/key-bindings.zsh
sudo wget -O /usr/share/fzf/key-bindings.zsh https://raw.githubusercontent.com/junegunn/fzf/d4ed955aee08a1c2ceb64e562ab4a88bdc9af8f0/shell/key-bindings.zsh
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => syncing files
# -----------------------------------------------------------------------------

echo -e '\n=> installing neovim'
sudo npm install -g neovim tree-sitter-cli
sudo pacman -S --noconfirm --needed neovim
echo -e '\n=> syncing doots'

chmod +x ~/Documents/dotFiles/postInstallScripts/*.sh
(cd ~/Documents/dotFiles/postInstallScripts/ && bash syncDootsLocal.sh)

# -----------------------------------------------------------------------------
# => Font
# -----------------------------------------------------------------------------

echo -e '\n=>Nerdfont'
mkdir -p ~/.local/share/fonts/ttf/
#TODO: use this address to download the font
#https://www.jetbrains.com/lp/mono/
rsync -auv ~/Documents/dotFiles/JetBrainsMono-2.242.zip ~/.local/share/
(cd ~/.local/share/ && unzip ./JetBrainsMono-2.242.zip )
rm ~/.local/share/AUTHORS.txt ~/.local/share/OFL.txt ~/.local/shareJetBrainsMono-2.242.zip
fc-cache -vf
echo -e 'Done.\n'


# -----------------------------------------------------------------------------
# => Keyboard Languages (en/cn)
# -----------------------------------------------------------------------------

echo -e 'Adding keyboard languages (cn)'
#https://classicforum.manjaro.org/index.php?topic=1044.0
# TODO: add --no needed 
sudo pacman -S --noconfirm --needed ibus-libpinyin opendesktop-fonts
sudo pacman -Ss --noconfirm --needed chinese
sudo sh -c "cat >> /etc/environment <<EOF
GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus
EOF"
# https://wiki.archlinux.org/title/IBus
touch ~/.config/autostart/ibus-daemon.desktop
cat >> ~/.config/autostart/ibus-daemon.desktop <<EOF
[Desktop Entry]
Type=Application
Name=IBus Daemon
Exec=ibus-daemon -drx
EOF
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Databases
# -----------------------------------------------------------------------------

echo -e '\n=>Installing Postgresql'
# https://lobotuerto.com/blog/how-to-install-postgresql-in-manjaro-linux/

yay -S --noconfirm postgresql postgis

echo -e 'Configuring Postgresql'
# need to pass commands directly investigate
sudo su postgres -l <<EOF # or sudo -u postgres -i
initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data/'
EOF
sudo systemctl start postgresql
sudo systemctl enable postgresql # allows it to start on start
# sudo systemctl status postgresql # visual confirmation
echo -e 'Done.\n'

echo -e '\n=>Installing Mongo'
git clone https://aur.archlinux.org/mongodb-bin.git ~/Programs/mongo/
cd ~/Programs/mongo/ && makepkg -si --noconfirm --needed

echo -e 'Configuring Mongo'
sudo systemctl start mongodb
sudo systemctl enable mongodb # allows it to start on start
# sudo systemctl status mongodb # visual confirmation
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Window manager
# -----------------------------------------------------------------------------

echo -e '\n=> install the window manager'
#TODO: install a better terminal than xterm(kitty)
sudo pacman -S --needed --noconfirm xmonad xmonad-contrib kitty dmenu
mkdir -p ~/.xmonad/
echo "downloading"
http  --download https://raw.githubusercontent.com/Vanderscycle/dot-config/main/postInstallScripts/endeavourOS/xmonad.hs > ~/.xmonad/xmonad.hs
echo -e 'Done.\n'

