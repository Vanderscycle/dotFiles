#!/bin/bash
# Manajaro post-install script

function beforeReboot() {
cd ~
echo '------------------------------------------------------------------------'
echo '=> Ubuntu 20.04LTS post-install script'
echo '=> Before reboot'
echo '------------------------------------------------------------------------'


echo -e '\n=> Update repository information '
# -S: synchronize your system's packages with those in the official repo
# -y: download fresh package databases from the server
# -u: upgrade all installed packages (like rsync)
sudo pacman -Syu
echo -e '=> Perform system upgrade'
sudo apt-get dist-upgrade -y
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Install system utilities
# -----------------------------------------------------------------------------

echo -e '\n=> Installing system utilities'
sudo pacman -Syu curl wget git lsof gdebi-core \
    zip unzip gzip tar \
    ssh \
    apt-transport-https ca-certificates gnupg lsb-release
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Install developer packages
# cmake used to compile a tmux plugin
# install nodejs nvim (plugin)
# -----------------------------------------------------------------------------

echo -e '\n=> Install developer packages'
sudo pacman -Syu git neovim python3-pip expect tmux rsync cmake
echo -e '\n=> Installing Node JS for py-right'
# More neovim packages
# https://www.chrisatmachine.com/Neovim/08-fzf/
sudo pacman -Syu fzf ripgrep universal-ctags silversearcher-ag fd-find
#https://github.com/neoclide/coc.nvim (node js install)
curl -sL install-node.now.sh/lts | bash
echo -e 'Done.\n'

# -----------------------------------------------------------------------------
# => Install Terminal Specific
# -----------------------------------------------------------------------------
# https://likegeeks.com/expect-command/
echo -e '\n=> Installing zsh and oh-my-zsh'
ssudo pacman -Sy zsh
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
export PATH="$PATH:$HOME/miniconda3/bin"

# Node js for vim plugin
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
EOF

# uncomment when you have conda
# conda update -y conda
# conda init zsh
echo -e '\ninstalling enhancd using zplug'
zplug "b4b4r07/enhancd", use:init.sh

echo -e '\n adding fzf completion'
# source of info https://doronbehar.com/articles/ZSH-FZF-completion/
sudo mkdir /usr/share/fzf/
sudo touch /usr/share/fzf/completion.zsh
sudo wget -O /usr/share/fzf/completion.zsh https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
sudo touch /usr/share/fzf/key-bindings.zsh
sudo wget -O /usr/share/fzf/key-bindings.zsh https://raw.githubusercontent.com/junegunn/fzf/d4ed955aee08a1c2ceb64e562ab4a88bdc9af8f0/shell/key-bindings.zsh

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
sudo mkdir .config/
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
# Coc plugins to install required functionalities
nvim +':CocInstall coc-pyright coc-sh coc-html coc-css coc-snippets' --headless +qa
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
beforeReboot
