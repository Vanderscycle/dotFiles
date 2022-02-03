
function nnnTheme
  set -xg BLK "04"
  set -xg CHR "04"
  set -xg DIR "04"
  set -xg EXE "00"
  set -xg REG "00"
  set -xg SYMLINK "06"
  set -xg ORPHAN "01"
  set -xg FIFO "0F"
  set -xg SOCK "0F"
  set -xg OTHER="02"
end

if status is-interactive
  # Commands to run in interactive sessions can go here
  # https://fishshell.com/docs/current/tutorial.html
  set -xg EDITOR lvim
  set -xg SHELL fish
  set -xg TERMINAL kitty
  set -xg LV_BRANCH rolling  
  keychain --eval --agents gpg,ssh ~/.ssh/endavourGit
  ssh-add ~/.ssh/endavourGit
  pokemon-colorscripts -r

  # nnn config
  # nnnTheme
  set -xg NNN_FCOLORS "$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
  set -xg NNN_FIFO '/tmp/nnn.fifo nnn'
  set -xg NNN_PLUG 'f:finder;o:fzopen;[:preview-tui;]:preview-tabbed;d:diffs;t:nmount;v:imgview'
  set -xg NNN_BMS 'd:~/Documents;u:~;D:~/Downloads;C:~/Documents/dotFiles/postInstallScripts;c:~/.config'
  set -xg NNN_OPTS He
  set -xg SPLIT 'v' # to split Kitty vertically
  set -xg LC_COLLATE 'C' # hidden files on top

  #kitty
  set -xg KITTY_LISTEN_ON unix:/tmp/kitty

  #gpg
  set -gx GPG_TTY (tty)
  
  # path -> Cargo, Conda 
  set -xg PATH "/home/henri/miniconda3/bin:/home/henri/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/henri/.cargo/bin:/home/henri.config/broot"
end


#aliases

function :q
  exit
end
# zellij
function zel
  zellij options --theme tokyonightDark $argv
end

function gsps
  exec ssh-agent fish
end

function htop
  bpytop
end

function npm 
	pnpm $argv
end

function ls
  exa -al $argv
end

function lvim $argv
 bash /home/henri/.local/bin/lvim $argv
end

function nvim
	lvim
end

function zx
  source ~/.config/fish/config.fish
end

# ~/.zshenv helper func
function save
  set currentLocation echo $PWD
  cd ~/Documents/dotFiles/postInstallScripts/
  bash ./lnSet.sh
  for option in $argv
    switch "$option"
      case -m --message
        git commit
      case \*
        git commit -m "$argv"
      end
    end
  git push
  cd $currentLocation # not working
end

function sync
  set currentLocation echo $PWD
  cd ~/Documents/dotFiles/postInstallScripts/
  git pull --all
  bash ./syncDootsLocal
  cd $currentLocation
end

function update
  sudo pacman -Syu
  xmonad --recompile
end

# function tx-ls

#pacman
# explanation https://stackoverflow.com/questions/48855508/fish-error-while-trying-to-run-command-on-mac/48855746
function pacman-ls
    pacman -Slq | fzf -m --preview 'bat (pacman -Si {1} | psub) (pacman -Fl {1} | awk "{print \$2}" | psub)' | xargs -ro sudo pacman -S
end

#yay
function yay-ls
    yay -Slq | fzf -m --preview 'bat (yay -Si {1} | psub) (yay -Fl {1} | awk "{print \$2}" | psub)' | xargs -ro  yay -S
end

function tmuxinator-ls 
    local ymlConfigs
    # because we changed the behavior of ls (alias:ls = exa -al) we can use exa as vanila ls.
    set -xg ymlConfigs (exa ~/.config/tmuxinator/ | fzf | cut -f 1 -d '.'| xargs)
    echo $ymlConfigs

    if [ -n "$ymlConfigs" ]
        tmuxinator start $ymlConfigs
    end
end



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/henri/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

