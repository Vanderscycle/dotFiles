#!/bin/bash

# -----------------------------------------------------------------------------
# => ArgParser
# https://medium.com/@Drew_Stokes/bash-argument-parsing-54f3b81a6a8f
# -----------------------------------------------------------------------------
# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx
# BUG: Keep track of the following solution (xmonad)
# https://forum.manjaro.org/t/gedit-plugin-warning-when-opening-from-terminal/75437
PARAMS=""
LOCATION=""
WM="default" # default being whateve we chose to install
GPU=""

while (( "$#" )); do
    case "$1" in
        -h|--home)
            LOCATION="home"
            shift
            ;;
        -w|--window-manager)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                WM=$2
                shift 2
            else
                echo "Error: Argument for $1 is missing" >&2
                exit 1
            fi
            ;;
        -g|--gpu)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                GPU=$2
                shift 2
            else
                echo "Error: Argument for $1 is missing" >&2
                exit 1
            fi
            ;;
        -*) # unsupported flags
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
    sudo pacman -S --noconfirm --needed archlinux-keyring
    sudo pacman -Syu --noconfirm
    yay -Syu --noconfirm
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
    echo -e 'Instaling Nvidea drivers \n'
    sudo pacman -S --needed --noconfirm nvidia-dkms mkinitcpio nvidia-installer-dkms
    yes yes | sudo nvidia-installer-dkms
    mkinitcpio -P
    echo -e 'Done.\n'
}

# TODO: test with amd
radeon(){
    # -----------------------------------------------------------------------------
    # => amd radeon drivers
    # https://wiki.archlinux.org/title/AMDGPU#Selecting_the_right_driver
    # -----------------------------------------------------------------------------
    echo -e 'Instaling AMD drivers \n'
    sudo pacman -S --needed --noconfirm radeontop
    echo -e 'Done.\n'
}

Ansible(){
    # -----------------------------------------------------------------------------
    # => Ansible + vault
    # ----------------------------------------------- ------------------------------
    echo -e 'Instaling AMD drivers \n'
    pip install ansible netaddr
    # autocomplete
    pip3 install argcomplete
    activate-global-python-argcomplete
    register-python-argcomplete --shell fish my-awesome-script | source

    sudo pacman -S --needed --noconfirm sshpass vault
    # creating the cfg file
    sudo mkdir -p /etc/ansible/
    ansible-config init --disabled -t all > ansible.cfg && sudo rsync -av ./ansible.cfg /etc/ansible/
    echo -e 'Done.\n'

}
terraform(){
    # -----------------------------------------------------------------------------
    # => Security (ssh/gpg/password manager)
    # -----------------------------------------------------------------------------

    echo -e '\n=> Configuring SSH'
    sudo pacman -S --noconfirm terraform
    echo -e 'Done.\n'
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

    echo -e '\n=>Installing Vault'
    sudo pacman -S --noconfirm --needed vault
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
    # timeshift backup
    yay -S --noconfirm --needed timeshift
    # create backup location https://www.youtube.com/watch?v=LkwZZIsY9uE
    sudo mkdir /mnt/backup
    sudo mkdir /mnt/nas
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

  echo -e '\n=> Installing kubernetes'
  sudo pacman -S --needed --noconfirm kubectl kubeseal argocd kustomize
  kubectl completion fish | source
  yay -S --needed --noconfirm kind-bin ctlptl-bin
  # otherwise you can install something like hyperkit and minikube start --vm-driver=minikube
  yay -S --needed --noconfirm k9s dive
  echo -e 'Done.\n'
  echo -e '\n=> Intalling Helm'
  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh && \
    rm get_helm.sh
  echo -e 'Done.\n'
  echo -e 'Installing Tilt\n'

  curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash
  echo -e 'Done.\n'
}

docker(){
  # -----------------------------------------------------------------------------
  # => Containers (docker)
  # -----------------------------------------------------------------------------
  echo -e '\n=> Installing Docker'
  # ctop is a vizualization tool for docker
  sudo pacman -S --noconfirm --needed docker ctop
  # https://wiki.archlinux.org/index.php/Docker
  # https://docs.docker.com/config/daemon/
  # touch /etc/docker/daemon.json # for specific user config
  sudo systemctl start docker
  sudo systemctl enable docker # allows it to start on start
  sudo systemctl status docker # visual confirmation

  echo -e '\n=> Installing Docker compose# '
  # sudo pacman -S --noconfirm docker-compose

  echo -e 'Removing Sudo requirements'
  sudo groupadd docker
  sudo usermod -aG docker "${USER}"
  echo -e 'Done.\n'
}

podman(){

  # -----------------------------------------------------------------------------
  # => Containers (Podman/buildah)
  # -----------------------------------------------------------------------------

  echo -e '\n=>Installing Podman(DockerFile reader) and Buildah(DockerFile writer)'
  sudo pacman -S --noconfirm --needed podman buildah

  echo -e '\n=>Configuring podman/buildah'
  sudo touch /etc/containers/registries.conf.d/docker.conf
  echo -e "${unqualified-search-registries=['docker.io']}" > /etc/containers/registries.conf.d/docker.conf
  sudo touch /etc/subuid
  sudo touch /etc/subgid
  sudo usermod --add-subuids 200000-201000 --add-subgids 200000-201000 henri

  sudo mkdir -p /root/buildah
  echo -e 'Done.\n'
}

3dPrinting(){
  # -----------------------------------------------------------------------------
  # => For Pruscia printer
  # -----------------------------------------------------------------------------

  echo -e '\n=>Installing Printer'
  sudo pacman -S --noconfirm --needed blender prusca-slicer
  echo -e 'Done.\n'
}

pythonInstall(){
  # -----------------------------------------------------------------------------
  # => Go language install and programs
  # -----------------------------------------------------------------------------

  echo -e '\n=> Installing Poetry'
  curl -sSL https://install.python-poetry.org | python3 -
  sudo pacman -S --noconfirm --needed python-poetry
  poetry config virtualenvs.in-project true
  poetry completions fish > ~/.config/fish/completions/poetry.fish
  curl https://pyenv.run | bash

  # echo -e '\n=> Installing Miniconda'
  # export CONDA_ALWAYS_YES="true" # allows us to skip conda asking for permission
  # cd "$HOME"
  # yay -S --needed --noconfirm miniconda3
  # sudo ln -s /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh
  # conda install -c python=3.9
  # conda install -c conda-forge pynvim
  # conda install -c conda-forge flake8
  # conda install -c conda-forge black
  #
  echo -e 'Done.\n'
  pip install ueberzug
}

golang(){
  # -----------------------------------------------------------------------------
  # => Go language install and programs
  # -----------------------------------------------------------------------------

  echo -e '\n=> installing golang'
  sudo pacman -S --needed --noconfirm go
  echo -e 'Done.\n'
}

antivirus(){

  # -----------------------------------------------------------------------------
  # => AV recommended by work
  # -----------------------------------------------------------------------------

  sudo pacman -S --needed --noconfirm clamav
}

ai (){

  # -----------------------------------------------------------------------------
  # => AI tools
  # -----------------------------------------------------------------------------
  pip install shell-gpt==0.8.3
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
  # Deno
  curl -fsSL https://deno.land/install.sh | sh
}

xmonad(){

  # -----------------------------------------------------------------------------
  # => Window manager (Xmonad)
  # -----------------------------------------------------------------------------
  # INFO: references: https://www.youtube.com/watch?v=3noK4GTmyMw
  curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
  echo -e '\n=> install the window manager and bar'
  sudo pacman -S --needed --noconfirm xmonad xmonad-contrib kitty wezterm dmenu wofi
  sudo pacman -S --needed --noconfirm nitrogen xorg-xrandr #wallpaper and else
  nitrogen ~/Documents/dotfiles/img/space.png
  sudo pacman -S --needed --noconfirm xmobar #more to polybar later
  yay -S --needed --noconfirm dunst #notification system
  yay -S --needed --noconfirm maim #screen capture
  sudo pacman -S --needed --noconfirm lxappearance #change teh defailt theme
  yay -S --needed --noconfirm xkb-switch #screen capture
  yay -S --needed --noconfirm picom-git #screen capture
  echo -e 'Done.\n'

  sudo pacman -S --needed --noconfirm playerctl # for audio controls
  sudo pacman -S --noconfirm zsa-wally # zsa keyboard
  }
awesome(){
  # -----------------------------------------------------------------------------
  # => Window manager (Xmonad)
  # -----------------------------------------------------------------------------

  sudo pacman -S --needed --noconfirm awesome lain #more to polybar later
  sudo pacman -S --needed --noconfirm flameshot
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
  sudo pacman -S --needed --noconfirm emacs aspell #  aspell for flyspell ( there are many languages however )
  yay -S --noconfirm protonmial-bridge mbsync-git # mail bridge for proton
  echo -e '\n=> installing Doom emacs'
  git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
  ~/.emacs.d/bin/doom install
  yay -S --noconfirm terraform-ls
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
  # fisher install ilancosman/tide # theme
  curl -sS https://starship.rs/install.sh | sh # startship
  fisher install franciscolourenco/done # notify when any process taking longer than 5 sec is done
  fisher install jorgebucaran/autopair.fish #same as tpope autopair
  fisher install PatrickF1/fzf.fish #fzf but fish
  fisher install edc/bass # allows bash in fish
  fisher install jorgebucaran/nvm.fish
  fisher install jethrokuan/z #zoxide?
  fisher install jorgebucaran/nvm.fish
  fisher install gazorby/fish-abbreviation-tips
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

  #bash
  yay -S --noconfirm --needed shellcheck-bin
  go install mvdan.cc/sh/v3/cmd/shfmt@latest

  #json
  sudo npm i -g jsonlint

  #yamll
  echo -e '\n=> installing yaml(lint)'
  sudo pacman -S --needed --noconfirm yamllint
  echo -e 'Done.\n'

  #python
  pip install isort

  #toml
  cargo install taplo-cli --locked

  #lua
  sudo pacman -S --needed --noconfirm luarocks #lua package manager
  luarocks install luacheck

  #haskell
  sudo pacman -S --needed --noconfirm ghcup-hs-bin


  #ts/js/etc.
  pnpm install -g svelte-language-server typescript typescript-language-server @tailwindcss/language-server emmet-ls

  # -----------------------------------------------------------------------------
  # => Develloper tools (Modern Unix)
  # -----------------------------------------------------------------------------

  echo -e '\n=> Installing developer packages and useful tui alternatives'
  sudo pacman -S --noconfirm --needed rsync git fzf github-cli bat fd exa lazygit unzip xclip task zoxide bpytop httpie
  sudo pacman -S --noconfirm --needed broot yq jq ripgrep the_silver_searcher ripgrep-all entr #entr is for file cahnges

  yay -S --needed --noconfirm ytfzf

}

guiPrograms(){

  # -----------------------------------------------------------------------------
  # => GUI programs
  # -----------------------------------------------------------------------------

  echo -e '\n=> installing gui programs'
  sudo pacman -S --noconfirm --needed signal-desktop nomacs #image viewwer/editor
  yay -S --needed --noconfirm vlc  postman-bin slack-desktop transmission-qt onlyoffice-bin
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
  yay -S --needed --noconfirm spotify

  #BUG: spotify must run first prior spicetify working
  echo -e '\n=> spicetify'
  yay -S --nocinfirm spicetify-cli
  #adjusting spotify permission
  #INFO: https://github.com/khanhas/spicetify-cli/wiki/Installation#spotify-installed-from-aur
  sudo chmod a+wr /opt/spotify
  sudo chmod a+wr /opt/spotify/Apps -R

  #Configuring spotify themes
  curl -fsSL https://raw.githubusercontent.com/NYRI4/Comfy-spicetify/main/install.sh | sh
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
  sudo pacman -S --needed --noconfirm steam gamemoderun
  yay -S --needed --noconfirm lib32-glu
  pip install mako
  yay -S --needed --noconfirm heroic-games-launcher-bin mangohud-git goverlay-bin
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

  echo -e '\n=> Installing AWS-cli'
  yay -S --needed --noconfirm aws-cli-v2 aws-session-manager-plugin
  echo -e 'Done.\n'

  echo -e '\n=> Installing Linode'
  pip3 install linode-cli boto3 --upgrade
  echo -e 'Done.\n'

  echo -e '\n=> Installing gitlab cli'
  pacman -S --needed --noconfirm glab
  echo -e 'Done.\n'
}

install(){

  # -----------------------------------------------------------------------------
  # => orchestrator
  # -----------------------------------------------------------------------------

  systemInit
  if [[ "$GPU" = "amd" ]]; then
    amd
  elif [[ "$GPU" = "nvidia" ]]; then
    nvidia
  fi
  fonts
  security
  languages
  fish
# bluetooth
  sudo pacman -S --needed bluez bluez-utils
sudo systemctl enable --now bluetooth

  #fisher
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
  ansible

  # programs
  cliPrograms
  cliClients
  guiPrograms
  spotify
  lunarvim
  emacs
  antivirus
  ai

  if [[ "$WM" = "xmonad" ]]; then
    xmonad
  fi

  if [[ "$WM" = "awesome" ]]; then
    awesome
  fi

  if [[ "$LOCATION" = "home" ]]; then
    discord
    file_sharing
    gaming
  fi

  #TODO: read about systemd to create a "callback" post reboot to install all of the fisher

  bash "$HOME"/Document/dotFiles/postInstallScripts/sync.sh -c sync # syncs the files
  reboot
}
install
