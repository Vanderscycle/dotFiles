# !/bin/bash

# sudo pacman -S --needed --noconfirm httpie &&
# wget https://raw.githubusercontent.com/Vanderscycle/dot-config/main/postInstallScripts/endeavourOS/endeavourOSXmonad.sh && chmod +x ./endeavourOSXmonad.sh && bash ./endeavourOSXmonad.sh
before_reboot(){
    # Do stuff

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
#BUG: httpie doesn't work
sudo pacman -S --needed --noconfirm curl wget

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

echo -e '\n=> Installing zsh'
yay -Syu --noconfirm --needed zsh

echo -e '\n=> Installing oh-my-zsh'
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended

echo -e '\n=> Installing zsh/oh-my-zsh plugins'
sudo pacman -S  --noconfirm --needed zsh-syntax-highlighting  zsh-autosuggestions  
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/supercrabtree/k ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/k
git clone https://github.com/lukechilds/zsh-better-npm-completion ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-better-npm-completion
#enhancd
mkdir -p ~/Programs/
git clone https://github.com/b4b4r07/enhancd ~/Programs/enhancd
echo "source ~/Programs/enhancd/init.sh"  >> ~/.zprofile
source ~/.zshrc
chsh -s  $(which zsh)

echo 'installing c lang'
pacman -S clang
echo -e 'Done.\n'

#Python
echo -e '\n=> Installing Miniconda'
cd ~
http --download https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b
export PATH=~/miniconda3/bin:$PATH
# conda init zsh
rm Miniconda3-latest-Linux-x86_64.sh # clean the install
conda  install -cy python pandas numpy
conda install -cy conda-forge pynvim
echo -e 'Done.\n'

#JS/TS
echo -e 'Installing nodeJs'
sudo pacman -S --noconfirm --needed nodejs npm
sudo npm i -g prettier eslint
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
# => Develloper tools
# -----------------------------------------------------------------------------

echo -e '\n=> Installing developer packages and useful tui alternatives'
sudo pacman -S --noconfirm rsync git fzf jq github-cli bat exa ripgrep lazygit htop unzip
#md file reader
yay -S --needed --noconfirm glow

# -----------------------------------------------------------------------------
# => Security (ssh)
# -----------------------------------------------------------------------------

echo -e 'Configuring SSH'
# https://pandammonium.org/how-to-change-a-git-repository-from-https-to-ssh/
mkdir ~/.ssh/
cd ~/.ssh/ && ssh-keygen -t ed25519 -C "hvandersleyen@gmail.com" -f endavourGit -N ""
eval $(ssh-agent)
ssh-add  ~/.ssh/endavourGit
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
chmod 700 ~/.gnupg
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Font && colors
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

echo -e '\n=>Colors in terminal'
yay -S --noconfirm shell-color-scripts pokemon-colorscripts-git
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
# => Containers (Docker)
# -----------------------------------------------------------------------------


echo -e '\n=>Installing Podman(DockerFile reader) and Buildah(DockerFile writer)'
sudo pacman -S --noconfirm --needed podman buildah
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
# INFO: references: https://www.youtube.com/watch?v=3noK4GTmyMw

echo -e '\n=> install the window manager and bar'
mkdir -p ~/.xmonad/
sudo pacman -S --needed --noconfirm xmonad xmonad-contrib kitty dmenu 
sudo pacman -S --needed --noconfirm nitrogen picom xorg-xrandr #wallpaper and else
sudo pacman -S --needed --noconfim xmobar #more to polybar later
http  --download https://raw.githubusercontent.com/Vanderscycle/dot-config/main/postInstallScripts/endeavourOS/xmonad.hs > ~/.xmonad/xmonad.hs
# xrandr 
mkdir -p ~/.config/xmobar/

http  --download https://raw.githubusercontent.com/Vanderscycle/dot-config/main/postInstallScripts/endeavourOS/xmobarrc> ~/.config/xmobar/xmobarrc

echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Last step
# -----------------------------------------------------------------------------

echo -e '\n=> Rebooting First time'
reboot
}

after_reboot(){
# -----------------------------------------------------------------------------
# => Virtual Machines (level 2)
# -----------------------------------------------------------------------------

echo '\n=>Installing vm'
#TODO: probably missing a few things
pacman -S --noconfirm virtualbox
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Local application (amazing tui)
# -----------------------------------------------------------------------------

echo '\n=>Installing amazing tui'
echo 'Installing bpytop (bashtop)'
conda -cy install psutil
pacman -S --noconfirm --needed bpytop

echo 'tui file navigator'
pacman -S --noconfirm --needed nnn
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Local application (gui)
# -----------------------------------------------------------------------------
echo '\n=> Installing local machine applications'
  yay -S --noconfirm zoom 
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => syncing files and installing Neovim
# -----------------------------------------------------------------------------

echo -e '\n=> installing neovim'

sudo rm -rf /usr/bin/tree-sitter

echo -e '\n=> installing neovim'
sudo npm install -g neovim tree-sitter-cli
sudo pacman -S --noconfirm --needed neovim

echo -e '\n=> installing LunarVim'
LV_BRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)

echo -e '\n=> syncing doots'
chmod +x ~/Documents/dotFiles/postInstallScripts/*.sh
(cd ~/Documents/dotFiles/postInstallScripts/ && bash syncDootsLocal.sh)

# -----------------------------------------------------------------------------
# => Last step
# -----------------------------------------------------------------------------

echo -e '\n=> Rebooting First time'
r
}

if [ -f /var/run/rebooting-for-updates ]; then
    after_reboot
    rm /var/run/rebooting-for-updates
    update-rc.d myupdate remove
else
    before_reboot
    touch /var/run/rebooting-for-updates
    update-rc.d myupdate defaults
    sudo reboot
fi

