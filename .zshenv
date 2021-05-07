export NEOMUTTPASSWORD=$(pass program/neomutt)

# gpg amd ssh
eval `keychain --eval --quiet --agents gpg,ssh ~/.ssh/manjaroGit`

# Python Conda envs
function activate-PYenv() {
    local selectedEnv 
    selectedEnv=$(ls ~/miniconda3/envs/ | fzf)

    if [ -n "$selectedEnv" ]
    then
        conda activate $selectedEnv
    fi
}
# not working
#tmuxinator
function tmuxinator-environments(){
    local ymlConfigs
    #ymlConfigs=$(ls ~/.config/tmuxinator/ | fzf | cut -f 1 -d '.'| xargs)
    ymlConfigs=$(tmuxinator list | fzf)
    echo $ymlConfigs

    if [ -n "$ymlConfigs"]
    then
        tmuxinator start $ymlConfigs
    fi
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
  local branchesToDelete
  branchesToDelete=$(git branch | fzf --multi | xargs)

  if [ -n "$branchesToDelete" ]; then 
    git branch --delete --force $branchesToDelete
  fi
}

