# #Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# I you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
plugins=(git fzf zsh-better-npm-completion zsh-autosuggestions zsh-syntax-highlighting sudo k)
export ZSH="/home/henri/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh


#fzf
export FZF_BASE=/usr/bin/fzf
export FZF_DEFAULT_COMMAND='rg'
DISABLE_FZF_KEY_BINDINGS="false"
DISABLE_FZF_AUTO_COMPLETION="false"

export TERMINAL=kitty
# Use powerline
USE_POWERLINE="true"
#BUG: do we even use zplug?
# #zplug addition
# if [ -f /home/henri/.zplug/init.zsh ]; then
#     source /home/henri/.zplug/init.zsh
# fi

# vim keys
#set -o vi

# to exit terminal in nvim
alias nvim=lvim
alias :q=exit
alias :qa=exit
alias htop=bpytop
alias ls="exa -al"
alias nvimMd="nvim --listen 127.0.0.1:9999"
alias gitSsh="eval `keychain --eval --agents gpg,ssh ~/.ssh/manjaroGit`"
alias poke="pokemon-colorscripts -r"
alias pokeCute="pokemon-colorscripts -n dewgong"
poke

#gpg
GPG_TTY=$(tty)
export GPG_TTY=$(tty)
export ENHANCD_FILTER="fzf --preview 'tree -d -C {} | head -100'"
export FZF_DEFAULT_COMMAND='fdfind --type f'
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --height=80%"
export PATH="/home/henri/miniconda3/bin:/home/henri/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/henri/.cargo/bin"
export EDITOR='lvim'

alias luamake=/home/henri/.config/lua-language-server/3rd/luamake/luamake 

# powerlevel10k
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
source ~/Programs/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# nnn config
BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
export NNN_FIFO='/tmp/nnn.fifo nnn'
export NNN_PLUG='f:finder;o:fzopen;[:preview-tui;]:preview-tabbed;d:diffs;t:nmount;v:imgview'
export NNN_BMS='d:~/Documents;u:~;D:~/Downloads;C:~/Documents/dotFiles/postInstallScripts;c:~/.config'
#INFO: b => {key} to reach bookamarks
export NNN_OPTS='He'
export SPLIT='v' # to split Kitty vertically
export NNN_BMS="h:~;d:~/Downloads;D:~/Documents"
export LC_COLLATE="C" # hidden files on top

#kitty
export KITTY_LISTEN_ON=unix:/tmp/kitty

# pnpm
alias npm=pnpm
export PNPM_HOME="/home/henri/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
