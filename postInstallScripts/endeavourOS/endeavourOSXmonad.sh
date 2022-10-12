#!/bin/bash

# -----------------------------------------------------------------------------
# => ArgParser
# https://medium.com/@Drew_Stokes/bash-argument-parsing-54f3b81a6a8f
# -----------------------------------------------------------------------------

PARAMS=""
LOCATION=""
WM="default" # default being whateve we chose to install

while (( "$#" )); do
  case "$1" in
    -h|--home)
      LOCATION="home"
      shift
      ;;
    -w|--window-manager)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        WM=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"
echo "$PARAMS $LOCATION $WM"

systemInit(){
  # -----------------------------------------------------------------------------
  # => Annoying programs that requires user permission
  # -----------------------------------------------------------------------------

  # -S: synchronize your system's packages with those in the official repo
  # -y: download fresh package databases from the server

  echo -e '=> Perform system update'
  sudo pacman -Syu --noconfirm
  yay -Syu --noconfirm --needed
  echo 'cli critical programs'
  sudo pacman -S --needed --noconfirm base-devel git curl wget clang yay
  yay -S --needed --noconfirm topgrade update-grub
  echo -e 'Done.\n'

  echo -e '\n=> importing our doots'
  git clone https://github.com/Vanderscycle/dot-config.git ~/Documents/dotFiles/
  mkdir -p ~/.xmonad/
  wget -O ~/.xmonad/xmonad.hs https://raw.githubusercontent.com/Vanderscycle/dot-config/main/postInstallScripts/endeavourOS/xmonad.hs 

  mkdir -p ~/.config/xmobar/
  wget -O ~/.config/xmobar/xmobarrc https://raw.githubusercontent.com/Vanderscycle/dot-config/main/postInstallScripts/endeavourOS/xmobarrc
  echo -e 'Done.\n'
}

nvidia(){

  # -----------------------------------------------------------------------------
  # => Nvidia drivers
  # https://wiki.archlinux.org/title/NVIDIA
  # -----------------------------------------------------------------------------
  sudo pacman -S --needed --noconfirm nvidia-dkms mkinitcpio nvidia-installer-dkms 
  yes yes | sudo nvidia-installer-dkms 
  mkinitcpio -P

}

security(){
  # -----------------------------------------------------------------------------
  # => Security (ssh/gpg/password manager)
  # -----------------------------------------------------------------------------

  echo -e '\n=> Configuring SSH'
  # https://pandammonium.org/how-to-change-a-git-repository-from-https-to-ssh/
  mkdir ~/.ssh/
  (cd ~/.ssh/ && ssh-keygen -t ed25519 -C "hvandersleyen@gmail.com" -f endavourGit -N "")
  eval "$(ssh-agent)"
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
  # gpg --full-gen-key
  # gpg --list-secret-keys --keyid-format=long
  # git config --global gpg.program (which gpg)
  # git config --global commit.gpgsign true
  gpg-connect-agent reloadagent /bye
  echo -e 'Done.\n'

  echo -e '\n=>Installing the password manager'
  sudo pacman -S --noconfirm --needed bitwarden
  echo -e 'Done.\n'

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


}

backupMaintenance(){

  # -----------------------------------------------------------------------------
  # => Enabling weekly system maintenance
  # -----------------------------------------------------------------------------

  echo -e '\n=> Enabling weekly system maintenance'
  sudo systemctl enable --now paccache.timer
  sudo pacman -S --noconfirm --needed fcitx fcitx-googlepinyin fcitx-configtool #TODO: double check the right dependence
  echo -e 'Done.\n'
}

languages(){

  # -----------------------------------------------------------------------------
  # => Keyboard Languages (en/cn)
  # -----------------------------------------------------------------------------

  echo -e 'Adding keyboard languages (cn)'
  #https://classicforum.manjaro.org/index.php?topic=1044.0
  # TODO: add --no needed 
  sudo pacman -S --noconfirm --needed fcitx fcitx-googlepinyin fcitx-configtool #TODO: double check the right dependence
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


}

mongo(){

  # -----------------------------------------------------------------------------
  # => Databases
  # -----------------------------------------------------------------------------

  echo -e '\n=>Installing Mongo'
  git clone https://aur.archlinux.org/mongodb-bin.git ~/Programs/mongo/
  (cd ~/Programs/mongo/ && makepkg -si --noconfirm --needed)

  echo -e 'Configuring Mongo'
  # sudo systemctl start mongodb
  # sudo systemctl enable mongodb 
  sudo systemctl enable --now mongodb
  sudo systemctl status mongodb # visual confirmation
  echo -e 'Done.\n'
}

postgresql(){

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
}

kubernetes(){

  # -----------------------------------------------------------------------------
  # => Kubernetes k8s 
  # -----------------------------------------------------------------------------

  echo -e '\n=> kubernetes'
  sudo pacman -S --needed --noconfirm kubectl  kubeseal argocd kustomize

  yay -S --needed --noconfirm kind-bin
  # otherwise you can install something like hyperkit and minikube start --vm-driver=minikube
  yay -S --needed --noconfirm k9s
  # pacman -S --needed --noconfirm dive
  echo -e 'Done.\n'
}

# docker(){
# -----------------------------------------------------------------------------
# => Containers (docker)
# -----------------------------------------------------------------------------
# }

podman(){

  # -----------------------------------------------------------------------------
  # => Containers (Podman/buildah)
  # -----------------------------------------------------------------------------

  echo -e '\n=>Installing Podman(DockerFile reader) and Buildah(DockerFile writer)'
  sudo pacman -S --noconfirm --needed podman buildah

  echo -e '\n=>Configuring podman/buildah'
  sudo touch /etc/containers/registries.conf.d/docker.conf 
  echo -e `unqualified-search-registries=["docker.io"]` > /etc/containers/registries.conf.d/docker.conf
  sudo touch /etc/subuid
  sudo touch /etc/subgid 
  sudo usermod --add-subuids 200000-201000 --add-subgids 200000-201000 henri

  sudo mkdir -p /root/buildah
  echo -e 'Done.\n'
}

pythonInstall(){
  # -----------------------------------------------------------------------------
  # => Go language install and programs 
  # -----------------------------------------------------------------------------

  echo -e '\n=> Installing Miniconda'
  export CONDA_ALWAYS_YES="true" # allows us to skip conda asking for permission
  cd "$HOME"  
  yay -S --needed --noconfirm miniconda3
  sudo ln -s /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh
  conda install -c python=3.9
  conda install -c conda-forge pynvim
  conda install -c conda-forge flake8
  conda install -c conda-forge black
  echo -e 'Done.\n'
  pip install ueberzug
}

golang(){
  # -----------------------------------------------------------------------------
  # => Go language install and programs 
  # -----------------------------------------------------------------------------

  echo -e '\n=> installing golang'
  pacman -S --needed --noconfirm go
  echo -e 'Done.\n'
}

rust(){
  # -----------------------------------------------------------------------------
  # => Rust language install and programs 
  # -----------------------------------------------------------------------------

  echo -e '\n=> installing rust'
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  cargo install cargo-update 
  echo -e 'Done.\n'
}

nodeJS(){
  # -----------------------------------------------------------------------------
  # => Node language install and programs 
  # -----------------------------------------------------------------------------

  echo -e '\n=> installing Node'
  sudo pacman -S --noconfirm --needed nodejs npm
  # installing pnpm
  curl -fsSL https://get.pnpm.io/install.sh | sh -
  sudo npm i -g prettier eslint neovim
  echo -e 'Done.\n'
}

xmonad(){

  # -----------------------------------------------------------------------------
  # => Window manager (Xmonad)
  # -----------------------------------------------------------------------------
  # INFO: references: https://www.youtube.com/watch?v=3noK4GTmyMw

  echo -e '\n=> install the window manager and bar'
  sudo pacman -S --needed --noconfirm xmonad xmonad-contrib kitty dmenu httpie
  sudo pacman -S --needed --noconfirm nitrogen xorg-xrandr #wallpaper and else
  nitrogen ~/Documents/dotfiles/img/space.png
  sudo pacman -S --needed --noconfirm xmobar hoogle #more to polybar later
  yay -S --needed --noconfirm dunst #notification system
  yay -S --needed --noconfirm maim #screen capture
  yay -S --needed --noconfirm xkb-switch #screen capture
  yay -S --needed --noconfirm picom-git #screen capture
  echo -e 'Done.\n'

  sudo pacman -S --needed --noconfirm playerctl # for audio controls
  sudo pacman -S --noconfirm zsa-wally # zsa keyboard
  sudo pacman -S --needed --noconfirm lxappareance #more to polybar later
  }

fonts(){
  
  # -----------------------------------------------------------------------------
  # => Font && colors
  # -----------------------------------------------------------------------------

  echo -e '\n=>Nerdfont'
  mkdir -p ~/.local/share/fonts/NerdFonts/JetBrains
  # https://github.com/ronniedroid/getnf
  #TODO: use this address to download the font
  #https://www.jetbrains.com/lp/mono/
  rsync -auv ~/Documents/dotFiles/theme/JetBrainsMono.zip ~/.local/share/fonts/NerdFonts/JetBrains/
  (cd ~/.local/share/fonts/NerdFonts/JetBrains && unzip ./JetBrainsMono.zip && rm ./JetBrainsMono )
  # rm  ~/.local/share/fonts/NerdFonts/JetBrainsMono.zip
  fc-cache -v -f
  echo -e 'Done.\n'

  echo -e '\n=> Adding emoji support'
  yay -S --noconfirm ttf-joypixels noto-fonts-extra
  mkdir ~/.config/fontconfig/
  rsync -av ~/Documents/dotFiles/fonts.conf ~/.config/fontconfig/
  echo -e 'Done.\n'

}

emacs(){

  # -----------------------------------------------------------------------------
  # => emacs (doom emacs)
  # -----------------------------------------------------------------------------

  echo -e '\n=> installing Emacs'
  sudo pacman -S --needed --noconfirm emacs
  echo -e '\n=> installing Doom emacs'
  git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
  ~/.emacs.d/bin/doom install
  echo -e 'Done.\n'
}

fish(){

  # -----------------------------------------------------------------------------
  # => fisher 
  # -----------------------------------------------------------------------------

  echo -e '\n=> Installing Fish'
  sudo pacman -S --noconfirm --needed fish
  echo -e 'Done. \n'

}

fisher(){

  # -----------------------------------------------------------------------------
  # => fisher 
  #INFO: the following must be done while executing in a fish shell
  # -----------------------------------------------------------------------------

  curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher # like zplug
  fisher install ilancosman/tide #use that or starship
  fisher install franciscolourenco/done # notify when any process taking longer than 5 sec is done
  fisher install jorgebucaran/autopair.fish #same as tpope autopair 
  fisher install PatrickF1/fzf.fish #fzf but fish
  fisher install edc/bass # allows bash in fish
  fisher install jorgebucaran/nvm.fish
  fisher install jethrokuan/z #zoxide?
  fisher install jorgebucaran/nvm.fish
  wget https://gitlab.com/kyb/fish_ssh_agent/raw/master/functions/fish_ssh_agent.fish -P ~/.config/fish/functions/
}

lunarvim(){
  # -----------------------------------------------------------------------------
  # => lunarvim 
  # -----------------------------------------------------------------------------

  echo -e '\n=> Installing Lvim'
  (cd "$HOME" && curl https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/inst
aller/install.sh -o lvim_installer.sh && bash lvim_installer --install-dependencies --yes)
 

  echo -e 'Done. \n'
}

lspNull(){

  # -----------------------------------------------------------------------------
  # => languages /linter/formatter (lsp)
  # npm/pnpm must be installed prior
  # golang must be installed prior
  # -----------------------------------------------------------------------------

  # rust (installs rustup which installs rust and cargo)

  # Markdown 
  yay -S --noconfirm --needed vale-bin
  sudo npm install -g write-good
  vale sync

  #bash
  yay -S --noconfirm --needed shellcheck-bin
  go install mvdan.cc/sh/v3/cmd/shfmt@latest

  #json
  sudo npm i -g jsonlint 

  #yamll
  echo -e '\n=> installing yaml(lint)'
  pacman -S --needed --noconfirm yamllint
  yay -S --needed --noconfirm actionlint-bin
  echo -e 'Done.\n'

  #python
  pip install isort

  #toml
  cargo install taplo-cli --locked

  #lua
  pacman -S --needed --noconfirm luarocks #lua package manager
  luarocks install luacheck

  #ts/js/etc.
  pnpm install -g svelte-language-server typescript typescript-language-server @tailwindcss/language-server emmet-ls

  # -----------------------------------------------------------------------------
  # => Develloper tools (Modern Unix)
  # -----------------------------------------------------------------------------

  echo -e '\n=> Installing developer packages and useful tui alternatives'
  sudo pacman -S --noconfirm --needed rsync git fzf github-cli bat exa lazygit htop unzip xclip task zoxide bpytop
  sudo pacman -S --noconfirm --needed broot jq ripgrep the_silver_searcher ripgrep-all entr #entr is for file cahnges

  yay -S --needed --noconfirm ytfzf 

}

guiPrograms(){

  # -----------------------------------------------------------------------------
  # => GUI programs
  # -----------------------------------------------------------------------------

  echo -e '\n=> installing gui programs'
  sudo pacman -S --noconfirm --needed signal-desktop nomacs #image viewwer/editor
  yay -S --needed --noconfirm vlc  postman-bin slack-desktop transmission-qt 
  # rpi-imager
  yay -S --needed --noconfirm zoom brave-bin zsa-wally brave-bin
  echo -e 'Done.\n'

  # -----------------------------------------------------------------------------
  # => Virtual Machines (level 2)
  # -----------------------------------------------------------------------------

  echo -e '\n=>Installing vm'
  # INFO: kvm too complex
  sudo pacman -S --noconfirm --needed virtualbox
  echo -e 'Done.\n'
}

cliPrograms(){

  # -----------------------------------------------------------------------------
  # => CLI PROGRAMS
  # -----------------------------------------------------------------------------

  echo -e '\n=> installing cli programs'
  yay -S --needed --noconfirm slides glow sysz
  echo -e 'Done.\n'

  echo -e 'tui file navigator'
  sudo pacman -S --noconfirm --needed mediainfo
  sudo pacman -S --noconfirm --needed sxiv

  pip install ueberzug #--required for file preview
  git clone https://github.com/jarun/nnn.git ~/Programs/nnn/
  (cd ~/Programs/nnn/ && sudo make O_NERD=1 && sudo cp nnn /bin/nnn   )
  # installing the plugins
  (cd ~/Programs/nnn/ && curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh)
  echo -e 'Done.\n'
}

spotify(){

  # -----------------------------------------------------------------------------
  # => spotify
  # -----------------------------------------------------------------------------

  echo -e '\n=> spotify'
  yay -S --needed --noconfirm spotify spicetify-cli

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
  echo -e 'Done.\n'

}
file_sharing(){

  # -----------------------------------------------------------------------------
  # => Enabling weekly system maintenance
  # -----------------------------------------------------------------------------

  echo -e '\n=> Enabling weekly system maintenance'
  sudo pacman -S --noconfirm --needed transmission-gtk
}
gaming(){

  # -----------------------------------------------------------------------------
  # =>  gaming clients
  # -----------------------------------------------------------------------------

  echo -e '\n=> installing steam/gog/epic'
  pacman -S --needed --noconfirm steam gamemoderun
  pip install mako
  yay -S --needed --noconfirm wine heroic-games-launcher-bin mangohud-git
  echo -e 'Done.\n'
}

discord(){

  # -----------------------------------------------------------------------------
  # => discord 
  # -----------------------------------------------------------------------------

  echo -e '\n=> discord'
  yay -S --needed --noconfirm discord
  curl -O https://raw.githubusercontent.com/bb010g/betterdiscordctl/master/betterdiscordctl
  chmod +x betterdiscordctl
  sudo mv betterdiscordctl /usr/local/bin
  betterdiscordctl install
  echo -e 'Done.\n'

}

cliClients () {
  # -----------------------------------------------------------------------------
  # => AWS
  # -----------------------------------------------------------------------------

  echo -e '\n=> installing AWS-cli'
  pacman -S --needed --noconfirm aws-cli-v2-bin
  echo -e 'Done.\n'
  #TODO: what about linode? have it run in a container?

}

# TODO: creates an arg-parser
install(){

  # -----------------------------------------------------------------------------
  # => orchestrator
  # -----------------------------------------------------------------------------

  systemInit
  nvidia
  fonts
  security
  languages
  fish
  chsh -s "$(which fish)" # change the default shell
  backupMaintenance

  # programming languages
  golang
  rust
  nodeJS
  pythonInstall

  # tools
  podman
  kubernetes
  lspNull
  
  # programs
  cliPrograms
  guiPrograms
  spotify
  lunarvim
  emacs
  if [[ "$WM" = "xmonad" ]]; then
    xmonad
  fi
  if [[ "$LOCATION" = "home" ]]; then
    discord
    file_sharing
    gaming
  fi

  #TODO: read about systemd to create a "callback" post reboot to install all of the fisher

  bash "$HOME"/Document/dotFiles/postInstallScripts/syncDootsLocal.sh # syncs the files
  reboot
}

