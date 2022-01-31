if status is-interactive
    # Commands to run in interactive sessions can go here
# https://fishshell.com/docs/current/tutorial.html
# set -x MyVariable SomeValue === export
  pokemon-colorscripts -r
  set -xg EDITOR lvim
  set -xg SHELL fish
  set -xg TERMINAL kitty
  set -xg LV_BRANCH rolling  
end

#aliases
function npm
	pnpm
end

function lvim
 bash /home/henri/.local/bin/lvim
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
  cd $currentLocation
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



