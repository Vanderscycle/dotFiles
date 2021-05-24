export NEOMUTTPASSWORD=$(pass program/neomutt)

# gpg amd ssh
eval `keychain --eval --quiet --agents gpg,ssh ~/.ssh/manjaroGit`

# Python Conda envs
function conda-ls() {
    local selectedEnv 
    selectedEnv=$(ls ~/miniconda3/envs/ | fzf)

    if [ -n "$selectedEnv" ]
    then
        conda activate $selectedEnv
    fi
}
# not working
#tmuxinator
function tmuxinator-ls(){
    local ymlConfigs
    ymlConfigs=$(ls ~/.config/tmuxinator/ | fzf | cut -f 1 -d '.'| xargs)
    #ymlConfigs=$(tmuxinator list | fzf --multi)
    echo $ymlConfigs

    if [ -n "$ymlConfigs" ]
    then
        tmuxinator start ${ymlConfigs}
    fi
}

## cheatsheet
## needs rework
function cht-sh() {
    language=${1}
    query=( "${@:2}" )
    curl cht.sh/${language}/${query[*]}\T
}

#postgresql
# gives the can't change dir error
function postgreSQL-createDB() {
    local DBNAME
    DBNAME=${1}
    sudo su postgres <<EOF
psql -c 'CREATE DATABASE ${DBNAME};'
EOF

}

function postgreSQL-createTable() {
    sudo su postgres <<EOF
psql -c 'SELECT datname FROM pg_database
WHERE datistemplate = false;'
EOF
}
#git
function checkout-branches() {
  local branchesAvailable
  branchesAvailable=$(git branch | fzf --multi | xargs)

  if [ -n "$branchesAvailable" ]
  then 
    echo $branchesAvailable
    git checkout $branchesAvailable
  fi
}

function delete-branches() {
  
  git branch |
    grep --invert-match '\*' |
    cut -c 3- |
    fzf --multi --preview='git log {} -- '|
    xargs --no-run-if-empty git branch --delete --force
}

function pr-checkout() {
  local pr_number

  pr_number=$(
    gh api 'repos/:owner/:repo/pulls' |
    jq --raw-output '.[] | "#\(.number) \(.title)"' |
    fzf |
    sed 's/^#\([0-9]\+\).*/\1/'
  )

  if [ -n "$pr_number" ]; then
    gh pr checkout "$pr_number"
  fi
}
#TODO 
# add the revert from a commit (log -> revert)

# Arch package search
# pacman
function pacman-ls () {
    pacman -Slq | fzf -m --preview 'bat <(pacman -Si {1}) <(pacman -Fl {1} | awk "{print \$2}")' | xargs -ro sudo pacman -S
}
# yay
function yay-ls () {
    yay -Slq | fzf -m --preview 'bat <(yay -Si {1}) <(yay -Fl {1} | awk "{print \$2}")' | xargs -ro  yay -S
}

# NPM
function npm-run() {
  local script
  script=$(bat package.json | jq -r '.scripts | keys[] ' | sort | fzf) && npm run $(echo "$script")
}

