#!bin/sh

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
# => Install system utilities
# -----------------------------------------------------------------------------

echo -e '\n=> Installing system utilities'
echo -e 'Installing AUR helper (yay)'
sudo pacman -S --noconfirm --needed yay

# c
echo 'installing c lang'
sudo pacman -S --noconfirm --needed  clang
echo -e 'Done.\n'


#Python


#JS/TS
echo -e 'Installing nodeJs'
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


# echo -e '\n=>Colors in terminal'
# yay -S --noconfirm shell-color-scripts pokemon-colorscripts-git
# echo -e 'Done.\n'



# -----------------------------------------------------------------------------
# => Enabling weekly system maintenance
# -----------------------------------------------------------------------------

echo -e '\n=> Enabling weekly system maintenance'
sudo systemctl enable --now paccache.timer
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
sudo pacman -S --noconfirm --needed sxiv

pip install ueberzug #--required for file preview
git clone https://github.com/jarun/nnn.git ~/Programs/
(cd ~/Programs/nnn/ && sudo make O_NERD=1 && sudo cp nnn /bin/nnn   )
# installing the plugins
(cd ~/Programs/nnn/ && curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh)
# https://www.reddit.com/r/linux4noobs/comments/jc7vcx/nnn_how_to_open_file_directly/
# xdg programs use xdg-open by default

echo -e "radically different browser with pivacy in mind"
sudo pacman -S --noconfirm --needed qutebrowser #TODO: learn the bindings and reconfig them to make sense
sudo pacman -S python-adblock
# :set content.blocking.method both
echo -e 'Done.\n'

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



yay -S --noconfirm --needed qimgv-light signal-desktop 
#INFO: removing the develope edition

# I actually rely on vim more than libreoffice
#sudo pacman -S --needed --noconfirm libreoffice-fresh
sudo yay -S --needed --noconfirm onlyoffice-bin 

# -----------------------------------------------------------------------------
# => Quad9 dns
# -----------------------------------------------------------------------------

cat >> /etc/resolv.conf << EOF
nameserver 9.9.9.9
nameserver 2620:fe::fe
domain dnsknowledge.com
options rotate
EOF
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

# -----------------------------------------------------------------------------
# => languages /linter/formatter (lsp)
# -----------------------------------------------------------------------------

  echo '\n=> npm packages for lsp and neovim'
  sudo npm install -g @nestjs/cli write-good markdown-pdf
  sudo npm install -g @tailwindcss/language-server
  sudo npm install -g  svelte-language-server @typescript-eslint/eslint-plugin

  # write-good is a linter for markdown 
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

  echo -e '\n=> installing lua'
  pacman --needed --noconfirm luarocks
  sudo luarocks install luacheck # linter
  cargo install stylua # formatter
  echo -e 'Done.\n'



  echo -e '\n=> installing md'
  yay --needed --noconfirm write-good
  echo -e 'Done.\n'

  echo -e '\n=> installing dockerfile linter'
  yay --needed --noconfirm hadolint-bin
  echo -e 'Done.\n'


  echo -e '\n=> haskell'
  yay --needed --noconfirm ghcup-hs-bin 
  echo -e 'Done.\n'



# -----------------------------------------------------------------------------
# =>linode 
# -----------------------------------------------------------------------------

echo -e '\n=> installing linode-cli'
yay --needed --noconfirm linode-cli-git
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => pihole 
# -----------------------------------------------------------------------------

# https://discourse.pi-hole.net/t/how-do-i-configure-my-devices-to-use-pi-hole-as-their-dns-server/245

# -----------------------------------------------------------------------------
# => Lunarvim
# -----------------------------------------------------------------------------


# BUG: honestly its not working
echo -e '\n=> installing LunarVim'
sudo rm -rf /usr/bin/tree-sitter
LV_BRANCH=rolling bash <(curl -O https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
sudo bash install.sh --noinstall-dependencies
rm install.sh
bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release)
echo -e 'Done.\n'

