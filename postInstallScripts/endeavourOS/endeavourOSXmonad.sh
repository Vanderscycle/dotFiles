#!/bin/bash
# sudo pacman -S --needed --noconfirm httpie && 
# WARN: due for a reboot and time in vr for bug testing
# wget https://raw.githubusercontent.com/Vanderscycle/dot-config/main/postInstallScripts/endeavourOS/endeavourOSXmonad.sh && chmod +x ./endeavourOSXmonad.sh && sudo bash ./endeavourOSXmonad.sh

before_reboot(){
    # Do stuff
#TODO: add the usb mounting https://www.youtube.com/watch?v=LkwZZIsY9uE
echo '------------------------------------------------------------------------'
echo '=> EndavourOs post-install script'
echo '=> pre reboot'
echo 'Current os version: Atantis'
echo 'wm: Xmonad w/ Xmobar'
echo '------------------------------------------------------------------------'

# -----------------------------------------------------------------------------
# => Critical programs that installs bug out later
# -----------------------------------------------------------------------------

sudo touch /var/run/rebooting-for-updates 
echo -e '\n=> installing neovim'
sudo pacman -S --noconfirm --needed neovim

echo -e '\n=> importing our doots'
git clone https://github.com/Vanderscycle/dot-config.git ~/Documents/dotFiles/
mkdir -p ~/.xmonad/
wget -O ~/.xmonad/xmonad.hs https://raw.githubusercontent.com/Vanderscycle/dot-config/main/postInstallScripts/endeavourOS/xmonad.hs 

mkdir -p ~/.config/xmobar/
wget -O ~/.config/xmobar/xmobarrc https://raw.githubusercontent.com/Vanderscycle/dot-config/main/postInstallScripts/endeavourOS/xmobarrc
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Annoying programs that requires user permission
# -----------------------------------------------------------------------------

echo -e '\n=> Installing zsh'
yay -S --noconfirm --needed zsh
echo -e '\n=> Update repository information'
# -S: synchronize your system's packages with those in the official repo
# -y: download fresh package databases from the server

echo -e '=> Perform system update'
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel git 
echo 'cli download programs'
#BUG: httpie doesn't work
sudo pacman -S --needed --noconfirm curl wget

#WARN: not working need to grep and replace
# sudo -- sh -c "echo Defaults env_reset,timestamp_timeout=300 >> /etc/sudoers"
echo -e 'Done.\n'



# -----------------------------------------------------------------------------
# => Install system utilities
# -----------------------------------------------------------------------------

echo -e '\n=> Installing system utilities'
echo -e 'Installing AUR helper (yay)'
sudo pacman -S --noconfirm --needed yay

# c
echo 'installing c lang'
sudo pacman -S --noconfirm --needed  clang
echo -e 'Done.\n'

#bash
sudo yay -S --noconfirm --needed shellcheck-bin
go install mvdan.cc/sh/v3/cmd/shfmt@latest
#Python
echo -e '\n=> Installing Miniconda'
export CONDA_ALWAYS_YES="true" # allows us to skip conda asking for permission
cd ~
yay -S --needed --noconfirm miniconda3
sudo ln -s /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh
conda install -c python=3.9
conda install -c conda-forge pynvim
conda install -c conda-forge flake8
conda install -c conda-forge black
echo -e 'Done.\n'

#JS/TS
echo -e 'Installing nodeJs'
sudo pacman -S --noconfirm --needed nodejs npm
sudo npm i -g prettier eslint neovim tree-sitter-cli
echo -e 'Done.\n'

echo -e '\n=> Installing Kitty'
sudo pacman -S --noconfirm kitty
echo -e 'Done.\n'

echo -e '\n=> Installing Tmux and tmuxinator'
sudo pacman -S --noconfirm tmux
sudo yay -S --noconfirm --needed tmuxinator
echo -e 'Done.\n'

echo -e '\n=> Installing Zellig'
sudo pacman -S --noconfirm --needed zellij
echo -e 'Done.\n'

#BUG: zplug not working at install
# echo -e '\n=> zplug'
# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
# echo -e '\ninstalling enhancd using zplug'
# zplug "b4b4r07/enhancd", use:init.sh #! doesn't work

# echo -e '\adding fzf completion'
# source of info https://doronbehar.com/articles/ZSH-FZF-completion/
#mkdir /usr/share/fzf/ # file exists
# sudo touch /usr/share/fzf/completion.zsh
# sudo wget -O /usr/share/fzf/completion.zsh https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
# sudo touch /usr/share/fzf/key-bindings.zsh
# sudo wget -O /usr/share/fzf/key-bindings.zsh https://raw.githubusercontent.com/junegunn/fzf/d4ed955aee08a1c2ceb64e562ab4a88bdc9af8f0/shell/key-bindings.zsh
# echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Develloper tools
# -----------------------------------------------------------------------------

echo -e '\n=> Installing developer packages and useful tui alternatives'
sudo pacman -S --noconfirm --needed rsync git fzf github-cli bat exa lazygit htop unzip xclip task
sudo pacman -S --noconfirm --needed broot jq ripgrep the_silver_searcher ripgrep-all entr ytfzf #entr is for file cahnges
sudo yay -S --noconfirm openshift-client-bin # redhat openshift
# installing pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -

#md file reader
yay -S --needed --noconfirm glow sysz

# -----------------------------------------------------------------------------
# => Security (ssh/gpg/password manager)
# -----------------------------------------------------------------------------

echo -e '\n=> Configuring SSH'
# https://pandammonium.org/how-to-change-a-git-repository-from-https-to-ssh/
mkdir ~/.ssh/
(cd ~/.ssh/ && ssh-keygen -t ed25519 -C "hvandersleyen@gmail.com" -f endavourGit -N "")
eval $(ssh-agent)
ssh-add  ~/.ssh/endavourGit
echo -e 'Done.\n'


#because everytime you open a new terminal you need to create an agent id
echo -e '\n=> Installing password manager (pass)'
sudo pacman -S --needed --noconfirm pass gnupg keychain
# https://www.gnupg.org/documentation/manuals/gnupg/Agent-OPTION.html
echo -e 'Done.\n'

echo -e '\n=> Adding hosts'
curl https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts --output ~/hosts
sudo cp ~/hosts /etc/hosts
rm ~/hosts
echo -e 'Done.\n'

echo -e '\n=>Configuring GPG'
mkdir ~/.gnupg/
touch ~/.gnupg/gpg.conf
touch ~/.gnupg/gpg-agent.conf
# https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e
echo 'use-agent' >> ~/.gnupg/gpg.conf
echo 'pinentry-mode loopback' >> ~/.gnupg/gpg.conf
chmod 700 ~/.gnupg

# https://dev.to/mage1k99/how-to-sign-commits-in-git-for-fish-shell-4o5i
gpg --full-gen-key
gpg --list-secret-keys --keyid-format=long
git config --global gpg.program (which gpg)
git config --global commit.gpgsign true
gpg-connect-agent reloadagent /bye
echo -e 'Done.\n'

echo -e '\n=>Installing the password manager'
sudo pacman -S --noconfirm --needed bitwarden

echo -e 'Done.\n'

#TODO: since I have 2 gpg k
#INFO: the rest has to be done manually (add the pub file to git for both ssh and gpg)



# -----------------------------------------------------------------------------
# => Font && colors
# -----------------------------------------------------------------------------

echo -e '\n=>Nerdfont'
mkdir -p ~/.local/share/fonts/NerdFonts/JetBrains
# https://github.com/ronniedroid/getnf
#TODO: use this address to download the font
#https://www.jetbrains.com/lp/mono/
rsync -auv ~/Documents/dotFiles/JetBrainsMono.zip ~/.local/share/fonts/NerdFonts/JetBrains/
(cd ~/.local/share/fonts/NerdFonts/JetBrains && unzip ./JetBrainsMono.zip && rm ./JetBrainsMono )
# rm  ~/.local/share/fonts/NerdFonts/JetBrainsMono.zip
fc-cache -v -f
echo -e 'Done.\n'

echo -e '\n=> Adding emoji support'
yay -S --noconfirm ttf-twemoji noto-fonts-extra
mkdir ~/.config/fontconfig/
rsync -av ~/Documents/dotFiles/fonts.conf ~/.config/fontconfig/
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
sudo pacman -S --noconfirm --needed fcitx fcitx-googlepinyin #TODO: double check the right dependence
# sudo pacman -Ss --noconfirm --needed chinese
sudo sh -c "cat >> /etc/environment <<EOF
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS='@im=fcitx'
EOF"


# https://wiki.archlinux.org/title/IBus
# touch ~/.config/autostart/ibus-daemon.desktop
# cat >> ~/.config/autostart/ibus-daemon.desktop <<EOF
# [Desktop Entry]
# Type=Application
# Name=IBus Daemon
# Exec=ibus-daemon -drx
# EOF
# echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Containers (Podman/buildah)
# -----------------------------------------------------------------------------

echo -e '\n=>Installing Podman(DockerFile reader) and Buildah(DockerFile writer)'
sudo pacman -S --noconfirm --needed podman buildah
sudo yay -S --noconfirm --needed podman-compose

echo -e '\n=>Configuring podman/buildah'
sudo touch /etc/containers/registries.conf.d/docker.conf 
echo `unqualified-search-registries=["docker.io"]` > /etc/containers/registries.conf.d/docker.conf
sudo touch /etc/subuid
sudo touch /etc/subgid 
sudo usermod --add-subuids 200000-201000 --add-subgids 200000-201000 henri

sudo mkdir -p /root/buildah
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Containers (Podman/buildah)
# -----------------------------------------------------------------------------
echo -e '\n=>Installing Container orchestration'


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
# sudo systemctl start postgresql
# sudo systemctl enable postgresql 
sudo systemctl enable --now postgresql
sudo systemctl status postgresql # visual confirmation
echo -e 'Done.\n'

echo -e '\n=>Installing Mongo'
git clone https://aur.archlinux.org/mongodb-bin.git ~/Programs/mongo/
(cd ~/Programs/mongo/ && makepkg -si --noconfirm --needed)

echo -e 'Configuring Mongo'
# sudo systemctl start mongodb
# sudo systemctl enable mongodb 
susdo systemctl enable --now mongodb
sudo systemctl status mongodb # visual confirmation
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Enabling weekly system maintenance
# -----------------------------------------------------------------------------
echo -e '\n=> Enabling weekly system maintenance'

sudo systemctl enable --now paccache.timer
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Window manager (Xmonad)
# -----------------------------------------------------------------------------
# INFO: references: https://www.youtube.com/watch?v=3noK4GTmyMw

echo -e '\n=> install the window manager and bar'
sudo pacman -S --needed --noconfirm xmonad xmonad-contrib kitty dmenu httpie
sudo pacman -S --needed --noconfirm nitrogen picom xorg-xrandr #wallpaper and else
nitrogen ~/Documents/dotfiles/img/space.png
sudo pacman -S --needed --noconfirm xmobar #more to polybar later
yay -S --noconfirm dunst #notification system
yay -S --noconfirm maim #screen capture
echo -e 'Done.\n'

}

after_reboot(){

cd ~
echo '------------------------------------------------------------------------'
echo '=> EndavorOs post-install script'
echo '=> post reboot'
echo 'Current os version: Atantis'
echo 'wm: Xmonad w/ Xmobar'
echo '------------------------------------------------------------------------'

# -----------------------------------------------------------------------------
# => Post reboot updates
# -----------------------------------------------------------------------------

echo '\n=>Installing vm'
sudo pacman -Syu --noconfirm
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Let's actually move to fish
# -----------------------------------------------------------------------------

echo -e '\n=> Installing Fish'
sudo pacman -S --noconfirm --needed fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher # like zplug
fisher install ilancosman/tide #use that or starship
fisher install franciscolourenco/done # notify when any process taking longer than 5 sec is done
fisher install jorgebucaran/autopair.fish #same as tpope autopair 
fisher install PatrickF1/fzf.fish #fzf but fish
fisher install edc/bass # allows bash in fish
fisher install jorgebucaran/nvm.fish
fisher install jethrokuan/z
echo -e 'Done. \n'


# -----------------------------------------------------------------------------
# => Fish but in zsh (through on-my-zsh)
# -----------------------------------------------------------------------------

# echo -e '\n=> Installing oh-my-zsh'
# sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended

# echo -e '\n=> Installing zsh/oh-my-zsh plugins'
# # sudo pacman -S  --noconfirm --needed zsh-syntax-highlighting  zsh-autosuggestions  
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/supercrabtree/k ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/k
# git clone https://github.com/lukechilds/zsh-better-npm-completion ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-better-npm-completion

# (cd ~/Programs && git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git)


# -----------------------------------------------------------------------------
# => Virtual Machines (level 2)
# -----------------------------------------------------------------------------

echo '\n=>Installing vm'
#TODO: probably missing a few things
sudo pacman -S --noconfirm --needed virtualbox
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Local applications (amazing TUI)
# -----------------------------------------------------------------------------

echo -e '\n=>Installing amazing tui'
echo -e 'Installing bpytop (bashtop)'
conda install -cy psutil
sudo pacman -S --noconfirm --needed bpytop asciinema

#TODO: revesit nnn
echo -e 'tui file navigator'
sudo pacman -S --noconfirm --needed mediainfo
sudo pacman -S --noconfirm --needed nnn sxiv
pip install ueberzug #--required for file preview
git clone https://github.com/jarun/nnn.git ~/Programs/
(cd ~/Programs/nnn/ && sudo make O_NERD=1 && sudo cp nnn /bin/nnn   )
# installing the plugins
(cd ~/Programs/nnn/ && curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh)

echo -e "radically different browser with pivacy in mind"
sudo pacman -S --noconfirm --needed qutebrowser #TODO: learn the bindings and reconfig them to make sense
sudo pacman -S python-adblock
# :set content.blocking.method both
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => lsp
# -----------------------------------------------------------------------------

echo '\n=> npm packages for lsp and neovim'
sudo npm install -g @nestjs/cli write-good markdown-pdf
sudo npm install -g @tailwindcss/language-server
sudo npm install -g  svelte-language-server @typescript-eslint/eslint-plugin
# write-good is a linter for markdown 

# -----------------------------------------------------------------------------
# =>  Android dev (so much pain) lul
# -----------------------------------------------------------------------------

#INFO: FOR MONDAY INSTALL
echo '\n=> Android tools for maximum pain, jk'
# sudo yay -S --noconfirm --needed android-studio java-openjfx android-tools
 
# npm install -g appium
# download the appImage and rsync that garbage from Downloads -> Programs 
# https://github.com/appium/appium-inspector/releases/tag/v2021.12.2
# chmod +x *.AppImage
echo -e 'done'

# -----------------------------------------------------------------------------
# => enhancing gnome
# -----------------------------------------------------------------------------

echo '\n=> Gnome tweaks'
sudo pacman -S --noconfirm --needed gnome-tweaks
echo -e 'done'

# -----------------------------------------------------------------------------
# => bluetooth
# -----------------------------------------------------------------------------

sudo pacman -S --needed --noconfirm bluez bluez-utils blueman
sudo sd "#AutoEnable=false" "AutoEnable=true" /etc/bluetooth/main.conf
sudo modprobe btusb
sudo systemctl enable --now bluetooth
# https://discovery.endeavouros.com/bluetooth/how-to-enable-disable-bluetooth-at-startup/2022/01/

# volume control
# https://gist.github.com/iamcaleberic/5d1b5663f57185410964449c5417b996
pacman -S --needed --noconfirm pulseaudio-equalizer pavucontrol
pactl load-module module-equalizer-sink
pactl load-module module-dbus-protocol

# -----------------------------------------------------------------------------
# => Local application (gui)
# -----------------------------------------------------------------------------

echo '\n=> Installing local machine applications'
curl -O https://raw.githubusercontent.com/bb010g/betterdiscordctl/master/betterdiscordctl
chmod +x betterdiscordctl
sudo mv betterdiscordctl /usr/local/bin
betterdiscordctl install

yay -S --noconfirm --needed qimgv-light signal-desktop 
pacman -S --noconfirm --needed gimp nomacs #image viewwer/editor
#INFO: removing the develope edition
pacman -R --noconfirm firefox-developer-edition

# I actually rely on vim more than libreoffice
#sudo pacman -S --needed --noconfirm libreoffice-fresh
sudo yay -S --needed --noconfirm onlyoffice-bin 

yay -S --needed --noconfirm discord vlc spotify spicetify-cli 
yay -S --needed --noconfirm postman-bin slack-desktop


#adjusting spotify permission
#INFO: https://github.com/khanhas/spicetify-cli/wiki/Installation#spotify-installed-from-aur
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R

#Configuring spotify themes
spicetify
spicetify backup apply enable-devtool
# BUG: something isn't right with spicetify
(cd ~/.config/spicetify/Themes/ &&
git clone https://github.com/NYRI4/Comfy-spicetify &&
spicetify config current_theme Comfy-spicetify &&
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1 &&
spicetify apply)

# launch config keeb
#BUG: cargo may not work tho :/


#TODO: add the betterDiscord folder to the sync and better10k
yay -S --noconfirm zoom transmission-qt
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Linux Gaming
# -----------------------------------------------------------------------------

echo -e '\n=> Gaming Monitah'
yay -S --needed --noconfirm steam  lutris
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Kubernetes k8s 
# -----------------------------------------------------------------------------

echo -e '\n=> Gaming Monitah'
sudo pacman -S --needed --noconfirm kubectl minikube
# since we have virtualBox installed it will detect virtual box as the hypervisor of choice.
# otherwise you can install something like hyperkit and minikube start --vm-driver=minikube
echo -e 'Done.\n'



# -----------------------------------------------------------------------------
# => syncing files 
# -----------------------------------------------------------------------------

echo -e '\n=> installing neovim npm plugins'
sudo npm install -g neovim tree-sitter-cli

echo -e '\n=> syncing doots'
chmod +x ~/Documents/dotFiles/postInstallScripts/*.sh
(cd ~/Documents/dotFiles/postInstallScripts/ && bash syncDootsLocal.sh)
}
# -- fish
source ~/.config/fish/config.fish
zx
# -- zsh
# source ~/.zshrc
# source ~/.zshenv

echo '=>Rust and cargo'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
zx
cargo install ripgrep fd-find
cargo install --branch main --git https://github.com/Kampfkarren/selene selene
cargo install stylua fd-find 
cargo install cargo-watch
git clone https://github.com/pop-os/keyboard-configurator     ~/Programs/Launch-keebs/ 
(cd ~/Programs/Launch-keebs && sudo cargo run --release)
echo -e 'Done.\n'

echo '=>Terraform'
pacman -S --needed --noconfirm terraform
echo -e 'Done.\n'


echo '=>Go'
pacman -S --needed --noconfirm go
go install golang.org/x/tools/gopls@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
echo -e 'Done.\n'

zx
# installing GolangCi-lint
sudo yay -S --needed --noconfirm golangci-lint
# go mon
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => AWS
# -----------------------------------------------------------------------------

echo -e '\n=> installing AWS-cli'
pacman --needed --noconfirm aws-cli
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Lunarvim
# -----------------------------------------------------------------------------


echo -e '\n=> installing lua'
pacman --needed --noconfirm luarocks
sudo luarocks install luacheck # linter
cargo install stylua # formatter
echo -e 'Done.\n'

# BUG: honestly its not working
echo -e '\n=> installing LunarVim'
sudo rm -rf /usr/bin/tree-sitter
LV_BRANCH=rolling bash <(curl -O https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
sudo bash install.sh --noinstall-dependencies
rm install.sh
bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release)
echo -e 'Done.\n'


# -----------------------------------------------------------------------------
# => emacs (doom emacs)
# -----------------------------------------------------------------------------
echo -e '\n=> installing Emacs'
pacman -S --needed --noconfirm emacs
echo -e '\n=> installing Doom emacs'
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
echo -e 'Done.\n'



if [ -f /usr/bin/endeavourOSXmonad.sh ]; then
  after_reboot
  rm ~/endeavourOSXmonad.sh 
  sudo rm /etc/systemd/system/endavoursInstaller.service /usr/bin/endeavourOSXmonad.sh
  sudo systemctl disable endavoursInstaller.service

else
  sudo ln ~/endeavourOSXmonad.sh /usr/bin/
  sudo curl -o /etc/systemd/system/endavoursInstaller.service https://raw.githubusercontent.com/Vanderscycle/dot-config/main/postInstallScripts/endeavourOS/endavoursInstaller.service
  sudo systemctl enable endavoursInstaller.service
  before_reboot
fi

