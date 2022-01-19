#! /bin/bash
function killPort(){
  lsof -i TCP:$1 | grep LISTEN | awk -F " " '{print$2}' | xargs kill -9
}

# gpg amd ssh
eval `keychain --eval --quiet --agents gpg,ssh ~/.ssh/endavourGit`

# doots related
function save(){
  ( cd ~/Documents/dotFiles/postInstallScripts/ &&
  bash ./lnSet.sh &&
  git commit -am "quicksave" &&
  git push)
}

function sync(){
    (cd ~/Documents/dotFiles/postInstallScripts/ &&
      git pull &&
      bash ./syncDootsLocal.sh)
}

function reinstall(){
    (cd ~/Documents/dotFiles/postInstallScripts/ &&
      bash ./reinstalLvim.sh)
}

# temp
function zx(){
  source ~/.zshrc
  source ~/.zshenv
}

# new env scripts
function newRepo(){
    ORIGINDIR=~/Documents/dotFiles/stdPatterns/
    TEMPARRAY=(ML TS)
    echo 'new ML (machine learning) project or TS (Typescript) project' 
    TYPEREPO=$(exa $ORIGINDIR | fzf)
    echo $TYPEREPO
    case $TYPEREPO in
        "newMLRepo.sh")
            FILE="newMLRepo.sh"
            ORIGINDIR="${ORIGINDIR}${FILE}"
            rsync -auv $ORIGINDIR .
            bash $FILE
            rm $FILE
        ;;
        "newTSRepo.sh") 
            FILE="newTSRepo.sh"
            ORIGINDIR="${ORIGINDIR}${FILE}"
            #echo $ORIGINDIR
            rsync -auv $ORIGINDIR .
            bash $FILE
            rm $FILE
        ;;
        *) echo 'please enter either ML or TS'
    esac        

}
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
    # because we changed the behavior of ls (alias:ls = exa -al) we can use exa as vanila ls.
    ymlConfigs=$(exa ~/.config/tmuxinator/ | fzf | cut -f 1 -d '.'| xargs)
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
