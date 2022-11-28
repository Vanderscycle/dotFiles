#!/bin/bash

declare -a SecureFiles=("github-gpg-private.yml" "gitlab-gpg-private.yml" "aws-config" "gitlab.yml" "github.yml")

SECURE_STR=""
for SECRET_FILE in "${SecureFiles[@]}"; do
  SECURE_STR="$PWD/$SECRET_FILE ${SECURE_STR}" 
done
decrypt(){
  echo "$SECURE_STR"
  ansible-vault decrypt "$SECURE_STR"
}

encrypt(){
  ansible-vault encrypt "$SECURE_STR"
}
decrypt

