# http://lewandowski.io/2016/10/fish-env/ 
function posix-source
	for i in (cat $argv)
		set arr (echo $i |tr = \n)
  		set -gx $arr[1] $arr[2]
	end
end

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


# https://fishshell.com/docs/current/tutorial.html
if status is-interactive
  # auto completion
  kubectl completion fish | source

  #sourcing secrets
  posix-source "$DOOTFILE_LOC".env

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

  # eval (ssh-agent -c)
  # https://www.funtoo.org/Funtoo:Keychain (currently not working for fish shell T_T)
  keychain --eval --agents gpg,ssh ~/.ssh/endeavourGit ~/.ssh/atreidesGit
  set -xg s kitty +kitten ssh

  # dotfiles
  set -xg DOOTFILE_LOC ~/Documents/dotFiles/

  # ripgrep
  set RIPGREP_CONFIG_PATH -xg ~/.config/rg/
 
  # argocd
  set -xg ARGO_LOCAL "admin1!admin"

  # aws/linode/cli login
  # TODO: create an fzf multi choice
  # set -xg AWS_PROFILE "atreides-non-prod" # ~/.aws/config #eks 
  set -xg AWS_PROFILE "atreides-build"


  # zoxide
  set -x _ZO_ECHO '1'
   zoxide init fish | source
  # vault
  set -xg VAULT_ADDR "https://vault.non-prod.atreidesaccount.io"
  # vault login -method=oidc

  # nnn config
  # nnnTheme
  set -u NNN_TMPFILE "/tmp/nnn"
  export NNN_TMPFILE
  set -xg NNN_FCOLORS "$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
  set -xg NNN_FIFO '/tmp/nnn.fifo'
  export NNN_FIFO
  set -xg NNN_PLUG 'f:finder;o:fzopen;v:imgview;p:preview-tui;t:preview-tabbed'
  set -xg NNN_BMS 'w:~/Documents/houseAtreides;d:~/Documents;u:~;D:~/Downloads;C:~/Documents/dotFiles/postInstallScripts;c:~/.config;p:~/Pictures/;s:~/.local/share/Steam/steamapps/common/Proton - Experimental;h:~/Documents/houseAtreides'
  set -xg NNN_OPTS "Hed"
  set -xg SPLIT 'v' # to split Kitty vertically
  set -xg LC_COLLATE 'C' # hidden files on top

  #kitty
  set -xg KITTY_LISTEN_ON unix:/tmp/kitty

  #gpg
  set -gx GPG_TTY (tty)
  
  # path -> Cargo, Conda 
  set -xg PATH "/home/henri/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/henri/.config/broot:/home/henri/.emacs.d/bin"
# poetry
  set -xg POETRY_HOME "/home/henri/.local/"
  set -xg PATH "$POETRY_HOME/bin" "$PATH"
# rust 
  set -xg RUST_HOME "/home/henri/.cargo"
  set -xg PATH "$RUST_HOME/bin" "$PATH"
# deno
  set -xg DENO_HOME "/home/henri/.deno"
  set -xg PATH "$DENO_HOME/bin" "$PATH"
# pnpm
  set -gx PNPM_HOME "/home/henri/.local/share/pnpm"
  set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
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
      
    # adding all the ssh keys
      ssh-add ~/.ssh/endeavourGit
      ssh-add ~/.ssh/atreidesGit
    # dumping the latest
      journalctl --since=today > ~/.error.log # look for Boot 
      touch /tmp/weather_report
      set -l TMP_FILE  /tmp/weather_report
      xmonad --recompile; xmonad --restart
      xrandr --output DP-2 --mode 3440x1440 --rate 144 # force the monitor to move from 60 to 144hz
      curl -s v2d.wttr.in/ | tee $TMP_FILE
    end
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
  git tag -a v"$argv" -m 'testing promotion'     
  git push origin --tags
end

# ssh/servers

function pihole 
  kitty +kitten ssh pi@192.168.1.154
end
function ans
  kitty +kitten ssh root@172.105.9.43
end
function kitty-ssh --description "kitty-ssh "
  kitty +kitten ssh "$argv"
end

#TODO: find the pi address automatically?
function pik8s
  kitty +kitten ssh pi@192.168.1.51
end

# INFO: better to havev a linode-cli config?
# function linode
#   s
# end

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

# kill port
function kill-port
  kill -9 (lsof -t -i:"$argv")
end
# go
function goGet 
  go get -u ./...
end

#npm/pnpm

function p 
	pnpm $argv
end

#dns/dog
function dig
  dog "$argv"
end

#aliases
function :q
  exit
end

function :qa
  exit
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
  eval exa -al"$argv"
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
	docker rm -f (docker ps -aq)
end

function docker-irmAll
  echo -e "Removing all images"
	docker rmi -f (docker images  -aq)
  	echo "done"
end

function docker-vrmAll
  echo -e "removing all volumes"
	docker volume rm -f (docker volume ls -aq )
	echo "done"
end

function docker-prmAll
echo -e "purging everything"
 	docker-crmAll
  docker-irmAll
  docker-vrmAll
	docker builder prune -afq
  echo "done"
end

# k8s
# INFO: for aliases you need eval
function k
  eval kubectl "$argv[..-1]"
end

function k-encode --description "k-encode <secret.yaml>"
  # echo -n "$argv" | base64
    yq '.data' "$argv" | jq -r 'values[]' | xargs -I '{}' bash -c  'echo -n {} | base64'

end


#INFO: https://stackoverflow.com/questions/24093649/how-to-access-remaining-arguments-in-a-fish-script
function k-s --description "secret <namespace> <secret-name>"
  kubectl -n "$argv[1]" get secret "$argv[2]" -o json | jq '.data | map_values(@base64d)'
end

function k8s-prmAll
echo -e "purging everything"
  kubectl delete all --all --namespaces
end
# docker containers
function linode-docker  #TODO: review
  docker run -it --rm -v (pwd):/work -w /work --entrypoint /bin/bash aimvector/linode:2.15.0
end

# ripgrep
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
  bash "$DOOTFILE_LOC"/postInstallScripts/sync.sh -c save
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
  bash "$DOOTFILE_LOC"/postInstallScripts/sync.sh -c sync
  # return to where we were
  cd $CURRENTLOCATION
end

# system/pacman
function update
  # create a backyp
  # sudo timeshift --create
  topgrade
  # sudo pacman -Syu
  xmonad --recompile
end

function tz-download --description "download <url>" # alternative curl -sL
  https --download "$argv"| tar xz 
end
function crash-log
  lvim ~/.error.log
end

# explanation https://stackoverflow.com/questions/48855508/fish-error-while-trying-to-run-command-on-mac/48855746
function pacman-ls
    pacman -Slq | fzf -m --preview 'bat (pacman -Si {1} | psub) (pacman -Fl {1} | awk "{print \$2}" | psub) --color=always -n' | xargs -ro sudo pacman -S
end

#yay
function yay-ls
    yay -Slq | fzf -m --preview 'bat (yay -Si {1} | psub) (yay -Fl {1} | awk "{print \$2}" | psub) --color=always -n' | xargs -ro  yay -S
end

function git-ls
  #TODO:h add a mv to ~/.local/bin
  curl -sL "$argv"| tar zx   
end

#INFO: not used anymore
function tmuxinator-ls 
    # because we changed the behavior of ls (alias:ls = exa -al) we can use exa as vanila ls.
    set -xg ymlConfigs (exa ~/.config/tmuxinator/ | fzf | cut -f 1 -d '.'| xargs)
    echo $ymlConfigs

    if [ -n "$ymlConfigs" ]
        tmuxinator start $ymlConfigs
    end
end
