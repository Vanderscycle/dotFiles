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

  # fish
  fish_config theme choose "fish default"

  # ssh
  # https://www.rockyourcode.com/ssh-agent-could-not-open-a-connection-to-your-authentication-agent-with-fish-shell/
  fish_ssh_agent
  starship init fish | source
  # eval (ssh-agent -c)
  # https://www.funtoo.org/Funtoo:Keychain (currently not working for fish shell T_T)
  keychain --eval --agents gpg,ssh ~/.ssh/endeavourGit ~/.ssh/atreidesGit
  set -xg s kitty +kitten ssh

  # aws/linode/cli login
  # TODO: create an fzf multi choice
  set -xg AWS_PROFILE "atreides-non-prod" # ~/.aws/config #eks 

  #kitty
  set -xg KITTY_LISTEN_ON unix:/tmp/kitty

end
  
# aliases/func
#fish
function fish_greeting
    echo Hello "$USER"!
    echo The time is (set_color yellow; date +%T; set_color normal) and this machine is called $hostname
    # pokemon-colorscripts -r
    # emacsStart
    if not test -f '/tmp/weather_report'

    # adding all the ssh keys
      ssh-add ~/.ssh/endeavourGit
      ssh-add ~/.ssh/atreidesGit
    # dumping the latest
      journalctl --since=today > ~/.error.log # look for Boot 
      touch /tmp/weather_report
      set -l TMP_FILE  /tmp/weather_report
      # xmonad --recompile; xmonad --restart
      xrandr --output DP-2 --mode 3440x1440 --rate 144 # force the monitor to move from 60 to 144hz
      # curl -s v2d.wttr.in/ | tee $TMP_FILE

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

function gFS --description "gFetch <branch name>"
  git fetch origin "$argv"
  git switch "$argv"
end

function gTestTags 
  git tag -l | xargs -n 1 git push --delete origin
  git tag -l | xargs git tag -d                   
  git tag -a v"$argv" -m 'testing promotion'     
  git push origin --tags
end

# ssh/servers

function kitty-ssh --description "kitty-ssh "
  kitty +kitten ssh "$argv"
end

#TODO: find the pi address automatically?
function pik8s
  kitty +kitten ssh pi@192.168.1.51
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

# kill port
function killport
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

function pnpx --description "npx but for pnpm"
# INFO: https://pnpm.io/cli/dlx
	pnpm dlx $argv
end

#dns/dog
function dig
  dog "$argv"
end

#aliases
function :q --description "exit like its vim"
  exit
end

function :qa --description "exit like its vim"
  exit
end

function ls
  eval exa -al"$argv"
end

# converter json => yaml
function j2y --description "<name>.json}"
  cat "$PWD"/"$argv" | python "$DOOTFILE_LOC"scripts/j2y.py > j2y.yaml
end


function aks --description "aks"
  set -xg AWS_PROFILE "atreides-non-prod" # ~/.aws/config #eks 
  aws sso login
  aws eks update-kubeconfig --region eu-west-1 --name atreides-non-prod
end

function local-k
  kubectl config use-context kind-infrastructure
end

function pik3s --description "local pi cluster"
  set -xg KUBECONFIG $HOME/Documents/infrastructure/infrastructure-k3s-kubeconfig.yaml
end


function lke --description "linode k8s cluster"
  set -xg KUBECONFIG $HOME/Documents/infrastructure/infrastructure-kubeconfig.yaml
end

function k-encode  --description "k-encode <secret.yaml>"
  # echo -n "$argv" | base64
    yq '.data' "$argv" | jq -r 'values[]' | xargs -I '{}' bash -c  'echo -n {} | base64'
end

#INFO: https://stackoverflow.com/questions/24093649/how-to-access-remaining-arguments-in-a-fish-script
function k-secret --description "secret <namespace> <secret-name>"
  kubectl -n "$argv[1]" get secret "$argv[2]" -o json | jq '.data | map_values(@base64d)'
end

function k-seal --description "secret <path> "
   kubeseal --cert kubeseal-public.pem -f "$argv"/secret.yaml -o yaml > "$argv"/sealed-secret.yaml
end

function k-build --description "secret <namespace> <secret-name>"
  kustomize build --load-restrictor LoadRestrictionsNone --enable-helm . > build.log
  bat build.log
end

function k8s-prmNamespace
echo -e "purging everything in ns: $argv"
  kubectl delete all --all -n "$argv"
end

#Tilt-kind
function tilt-purge --description "restart the local cluster"""
  docker-crmAll
  ctlptl create registry ctlptl-registry
  ctlptl apply -f "$DOOTFILE_LOC"scripts/tilt-kind.yaml
end

#Helm
function helm-compile --description "helm-compile <name chart>"
	helm install "$argv" .
end

function helm-degug --description "helm-debug <name chart>"
	helm install --debug --dry-run "$argv" .
end

function helm-get --description "helm-get <name chart>"
	helm get manifest "$argv" 
end

function helm-template --description "helm-template <name chart>"
	helm template "$argv" . | tee "$argv".log.yaml
end

function helm-ignore --description "helm-ignore <.>"
  helm template . --output-dir=file-size-test
  tree --du -h file-size-test
  rm -rf file-size-test
end

#terraform
function t-apply
  terraform plan --out=output.tfplan
end

function t-execute
  terraform apply output.tfplan
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

function bios-boot 
  systemctl reboot --firmware-setup
end


fish_add_path /home/henri/.spicetify

function emacsStart
  emacsclient -n -e "(if (> (length (frame-list)) 1) 't)" ^ /dev/null | grep --silent t
  if test $status -eq 1
    # not running, -a '' starts a new server
    emacsclient -a '' -nqc $argv > /dev/null ^ /dev/null
  else
    emacsclient -nq $argv > /dev/null ^ /dev/null
  end
end
