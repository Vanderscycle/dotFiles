
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

  # dotfiles
  set -xg DOOTFILE_LOC ~/Documents/dotFiles/


  # nnn config
  # nnnTheme
  set -xg NNN_FCOLORS "$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
  set -xg NNN_FIFO '/tmp/nnn.fifo nnn'
  set -xg NNN_PLUG 'f:finder;o:fzopen;[:preview-tui;]:preview-tabbed;d:diffs;t:nmount;v:imgview'
  set -xg NNN_BMS 'd:~/Documents;u:~;D:~/Downloads;C:~/Documents/dotFiles/postInstallScripts;c:~/.config;p:~/Pictures/'
  set -xg NNN_OPTS HE
  set -xg SPLIT 'v' # to split Kitty vertically
  set -xg LC_COLLATE 'C' # hidden files on top

  #kitty
  set -xg KITTY_LISTEN_ON unix:/tmp/kitty

  #gpg
  set -gx GPG_TTY (tty)
  
  # path -> Cargo, Conda 
  set -xg PATH "/home/henri/miniconda3/bin:/home/henri/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/henri/.cargo/bin:/home/henri.config/broot"

  # java && android 
  # set -xg JAVA_HOME "/usr/bin/java"
  # set -xg ANDROID_HOME "/home/henri/Android/Sdk"

  # golang
  set -x GOPATH $HOME/go
  set -x PATH $PATH $GOPATH/bin
end



# go

function goGet 
  go get -u ./...
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
  # eval run 
  # exec runs a new shell
  if [ "$argv" = '-r' ]
    exec ssh-agent fish
  else 
    eval ssh-agent -s
  end
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

function glowAll
  exa -a | entr -c  glow  "$argv"
end

#Podman
function podman-crmAll
  echo -e "Removing all containers"
  podman rm --all --force
  echo "done"
 
end

function podman-prmAll
  echo -e "pruging everything"
  podman-compose stop
  podman-crmAll
  podman system prune --all --force && podman rmi --all --force
  echo "done"
end



# Docker
function docker-crmAll
    echo -e "Removing all containers"
	docker stop (docker ps -q)
	docker rm (docker ps -a -q)
end

function docker-irmAll
	docker-crmAll
  echo -e "Removing all images"
	docker rmi (docker images -f "dangling=true" -q)
  	echo "done"
end

function docker-vrmAll
  docker-irmAll
  echo -e "removing all volumes"
	docker volume rm (docker volume ls -qf dangling=true)
	echo "done"
end

function docker-prmAll
echo -e "purging everything"
  docker-vrmAll
	docker builder prune -af
  echo "done"
end

# ~/.zshenv helper func
# TODO: FIX ME!!!!
function rga-fzf 
	set RG_PREFIX "rga --files-with-matches"
	set file "(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
end

function rgr 
  # set -l DOOTFILE_LOC ~/Documents/dotFiles/
  bash "$DOOTFILE_LOC"/rgr.sh "$argv"
end

function save
  set -l CURRENTLOCATION pwd
  cd ~/Documents/dotFiles/postInstallScripts/
  bash ./lnSet.sh
  git add *
  git commit -am "Everything that is not saved will be lost"
  git push
  cd $CURRENTLOCATION # not working
end

function sync
  set -l CURRENTLOCATION pwd
  cd ~/Documents/dotFiles/postInstallScripts/
  git pull --all
  bash ./syncDootsLocal.sh
  cd $CURRENTLOCATION
end

function update
  sudo pacman -Syu
  xmonad --recompile
end

function pruneCache
  sudo paccache -r
end


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
    # because we changed the behavior of ls (alias:ls = exa -al) we can use exa as vanila ls.
    gsps
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

