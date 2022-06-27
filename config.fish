
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
  # https://fishshell.com/docs/current/tutorial.html

  # weather 
  # curl -s 'wttr.in/?format=3'

  # General variables
  set -xg EDITOR lvim
  set -xq BROWSER qutebrowser
  set -xg SHELL fish
  set -xg TERMINAL kitty
  set -xg LV_BRANCH rolling 

  # fzf
  set -xg fzf_preview_dir_cmd exa --all --color=always
  set -xg fzf_preview_file_cmd bat
  set -xg FZF_DEFAULT_OPTS '--multi --no-height --extended --bind "alt-a:select-all,alt-d:deselect-all"'
  
  # fish
  fish_config theme choose "fish default"

  # ssh
  # https://www.rockyourcode.com/ssh-agent-could-not-open-a-connection-to-your-authentication-agent-with-fish-shell/
  fish_ssh_agent
  ssh-add ~/.ssh/endavourGit
  ssh-add ~/.ssh/atreidesGit
  # eval (ssh-agent -c)
  # https://www.funtoo.org/Funtoo:Keychain (currently not working for fish shell T_T)
  keychain --eval --agents gpg,ssh ~/.ssh/endavourGit ~/.ssh/atreidesGit


  # dotfiles
  set -xg DOOTFILE_LOC ~/Documents/dotFiles/

  # ripgrep
  set RIPGREP_CONFIG_PATH -xg ~/.config/rg/

  # zoxide
  set -x _ZO_ECHO '1'
   zoxide init fish | source

  # nnn config
  # nnnTheme
  set -u NNN_TMPFILE "/tmp/nnn"
  export NNN_TMPFILE
  set -xg NNN_FCOLORS "$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
  set -xg NNN_FIFO '/tmp/nnn.fifo'
  export NNN_FIFO
  set -xg NNN_PLUG 'f:finder;o:fzopen;v:imgview;p:preview-tui;t:preview-tabbed'
  set -xg NNN_BMS 'w:~/Documents/houseAtreides;d:~/Documents;u:~;D:~/Downloads;C:~/Documents/dotFiles/postInstallScripts;c:~/.config;p:~/Pictures/'
  set -xg NNN_OPTS "Hed"
  set -xg SPLIT 'v' # to split Kitty vertically
  set -xg LC_COLLATE 'C' # hidden files on top

  #kitty
  set -xg KITTY_LISTEN_ON unix:/tmp/kitty

  #gpg
  set -gx GPG_TTY (tty)
  
  # path -> Cargo, Conda 
  set -xg PATH "/home/henri/miniconda3/bin:/home/henri/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/henri/.cargo/bin:/home/henri/.config/broot:/home/henri/.emacs.d/bin"

  # golang
  set -xg GOPATH $HOME/go
  set -xg PATH $PATH $GOPATH/bin

end
  
# aliases/func
#fish
function fish_greeting
    echo Hello "$USER"!
    echo The time is (set_color yellow; date +%T; set_color normal) and this machine is called $hostname
    # pokemon-colorscripts -r
    if not test -f '/tmp/weather_report'
      touch /tmp/weather_report
      set -l TMP_FILE  /tmp/weather_report
      curl v2d.wttr.in/ | tee $TMP_FILE
    end
end
# kitty
function icat
  kitty +kitten icat "$argv"
end
# nnn
function n
  nnn "$argv"
  if test -e $NNN_TMPFILE
    source $NNN_TMPFILE
    rm -rf $NNN_TMPFILE
  end
end

# git
function gSquash 
    git reset (git merge-base "$argv" (git branch --show-current))

end

function gTestTags 
  git tag -l | xargs -n 1 git push --delete origin
  git tag -l | xargs git tag -d                   
  git tag -a v0.0.2"$argv"-pre -m 'delete me later'     
  git push origin --tags
end


# ssh/servers
function pihole 
  ssh pi@192.168.1.154
end

function linode
  ssh
end

#fish
function fzf_complete
    set -l cmdline (commandline)
    # HACK: Color descriptions manually.
    complete -C | string replace -r \t'(.*)$' \t(set_color $fish_pager_color_description)'$1'(set_color normal) \
    | fzf -d \t -1 -0 --ansi --header="$cmdline" --height="80%" --tabstop=4 \
    | read -l token
    # Remove description
    set token (string replace -r \t'.*' '' -- $token)
    commandline -rt "$token"
end

bind \t 'fzf_complete; commandline -f repaint'
#conda/python
function condaUpdate
  conda update --all -y
end

# kill port
function kill-port
  kill -9 $(lsof -t -i:"$argv")
end
# go
function goGet 
  go get -u ./...
end

#npm/pnpm
function p-lock
  npm i --package-lock-only "$argv"

end

function p 
	pnpm $argv
end

#dns/dog
function dig
  dog "$argv"
end

# zellij
function zel
  zellij options --theme tokyonightDark $argv
end


#aliases
function :q
  exit
end

function :qa
  exit
end

function gsps
  # eval run 
  # exec runs a new shell


  if [ "$argv" = '-a' ]
    #TODO: find all the keys and add them
    ssh-add ~/.ssh/atreidesGit
    ssh-add ~/.ssh/endavourGit
  end
  if [ "$argv" = '-r' ]
    exec ssh-agent fish
  # else 
  #   ssh-agent /usr/bin/fish
    # eval ssh-agent fish
  end
end

function img
  nomacs "$argv"
end

function fishy
  lvim ~/.config/fish/config.fish
end


function htop
  bpytop #"$argv"
end


function ls
  exa -al"$argv"
end

function lvim 
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
#TODO: add kubectl get/apply describe/ etc 
#k8s

#Podman
function podman-crmAll
  echo -e "Removing all containers"
  podman rm --all --force
  echo "done"
 
end

function podman-irmAll
    echo -e "Removing all images"
  podman rmi --all --force
  echo "done"
end

function podman-prmAll
  echo -e "pruging everything"
  podman-compose stop
  podman-crmAll
  podman system prune --all --force 
  echo "done"
end

# Docker
function docker-crmAll
    echo -e "Removing all containers"
	# docker stop (docker ps -q)
	docker rm -f (docker ps -a -q)
end

function docker-irmAll
  echo -e "Removing all images"
	docker rmi (docker images -f "dangling=true" -q)
  	echo "done"
end

function docker-vrmAll
  echo -e "removing all volumes"
	docker volume rm (docker volume ls -qf dangling=true)
	echo "done"
end

function docker-prmAll
echo -e "purging everything"
 	docker-crmAll
  docker-irmAll
  docker-vrmAll
	docker builder prune -af
  echo "done"
end

function rga-fzf 
  bash "$DOOTFILE_LOC"/scripts/rga-fzf.sh "$argv"
end

function rgr 
  bash "$DOOTFILE_LOC"/scripts/rgr.sh "$argv"
end

function save
  # save our current location 
  set -l CURRENTLOCATION $PWD
  # cd into the dotfile folder for git
  cd "$DOOTFILE_LOC"
  bash "$DOOTFILE_LOC"/postInstallScripts/lnSet.sh
  git cmp "Everything that is not saved will be lost"
  # return to where we were
  cd "$CURRENTLOCATION"
end

function sync
  # save our current location 
  set -l CURRENTLOCATION $PWD
  # cd into the dotfile folder for git
  cd "$DOOTFILE_LOC"
  git pull --all
  bash  "$DOOTFILE_LOC"/postInstallScripts/syncDootsLocal.sh
  # return to where we were
  cd $CURRENTLOCATION
end

#pacman
function update
  sudo pacman -Syu
  xmonad --recompile
end

function pacPruneCache
  sudo paccache -r
end

# explanation https://stackoverflow.com/questions/48855508/fish-error-while-trying-to-run-command-on-mac/48855746
function pacman-ls
    pacman -Slq | fzf -m --preview 'bat (pacman -Si {1} | psub) (pacman -Fl {1} | awk "{print \$2}" | psub) --color=always -n' | xargs -ro sudo pacman -S
end

#yay
function yay-ls
    yay -Slq | fzf -m --preview 'bat (yay -Si {1} | psub) (yay -Fl {1} | awk "{print \$2}" | psub) --color=always -n' | xargs -ro  yay -S
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


