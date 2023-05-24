#!/bin/bash

OPERATION=""
LOCATION=""

while (( "$#" )); do
  case "$1" in
    -l|--load)
      LOCATION="home"
      shift
      ;;
    -o|--operation)
      if [ -n "$2" ] && [ $"{2:0:1}" != "-" ]; then
        OPERATION=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
declare -a SecureFiles=("github-gpg-private.key" "gitlab-gpg-private.key" "aws-config" "atreidesGit" "endeavourGit" ".env-general" "terraform")

decrypt(){

  ansible-vault decrypt "$PWD/.env-pass"
  for SECRET_FILE in "${SecureFiles[@]}"; do
    ansible-vault decrypt "$PWD/$SECRET_FILE" --vault-pass-file .env-pass
  done
  ansible-vault encrypt "$PWD/.env-pass"

}

encrypt(){

  ansible-vault decrypt "$PWD/.env-pass"
  for SECRET_FILE in "${SecureFiles[@]}"; do
    ansible-vault encrypt "$PWD/$SECRET_FILE"  --vault-pass-file .env-pass
  done
  ansible-vault encrypt "$PWD/.env-pass"

}

declare -a GPGKeys=("github-gpg-private.key" "gitlab-gpg-private.key")
declare -a SSHKeys=("atreidesGit" "atreidesGit.pub" "endeavourGit" "endeavourGit.pub")
load-gpg(){
  for GPG_KEY in "${GPGKeys[@]}"; do
    gpg --import "$GPG_KEY"
  done

}

load-ssh(){
  for SSH_KEY in "${SSHKeys[@]}"; do
    rsync -av --progress  "$SSH_KEY" "$HOME/.ssh/" 
  done

}

#TODO be able to target specific files. Also decrypt should encrypt files right away
if [[ "${OPERATION}" = "decrypt" ]];then
  decrypt
  if [[ "${LOCATION}" = "ssh" ]];then
    load-gpg
    load-ssh
    elif [[ "${LOCATION}" = "env" ]];then
    rsync -av --progress .env-general "$HOME/Documents/dotFiles/.env"
  fi
elif [[ "${OPERATION}" = "encrypt" ]];then
  encrypt
fi



