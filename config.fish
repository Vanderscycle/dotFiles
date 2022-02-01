if status is-interactive
    # Commands to run in interactive sessions can go here
# https://fishshell.com/docs/current/tutorial.html
# set -x MyVariable SomeValue === export
  set -xg EDITOR lvim
  set -xg SHELL fish
  set -xg TERMINAL kitty
  set -xg LV_BRANCH rolling  
  keychain --eval --agents gpg,ssh ~/.ssh/endavourGit
  ssh-add ~/.ssh/endavourGit
  pokemon-colorscripts -r

  # nnn config
# BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
set -xg NNN_FCOLORS "$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
set -xg NNN_FIFO '/tmp/nnn.fifo nnn'
set -xg NNN_PLUG 'f:finder;o:fzopen;[:preview-tui;]:preview-tabbed;d:diffs;t:nmount;v:imgview'
set -xg NNN_BMS 'd:~/Documents;u:~;D:~/Downloads;C:~/Documents/dotFiles/postInstallScripts;c:~/.config'
set -xg NNN_OPTS He
set -xg SPLIT 'v' # to split Kitty vertically
set -xg LC_COLLATE 'C' # hidden files on top
end


#aliases
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
function yay-ls () 
    yay -Slq | fzf -m --preview 'bat (yay -Si {1} | psub) (yay -Fl {1} | awk "{print \$2}" | psub)' | xargs -ro  yay -S
end



