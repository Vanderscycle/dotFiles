#!/bin/bash

# load the secrets for this script
if [ -f .env ]
then
  source .env
else
    echo "[MISSING] : missing .env file" 
    exit 125
fi


DIR='/home/root/'
LOCAL_DIR=$PWD
echo $DIR $LOCAL_DIR $SET_UP

if [ ! -n "$SET_UP" ]
then
  ssh "$USER"@"$LINODE_IP" 'apk add bash'
  ssh "$USER"@"$LINODE_IP" 'bash -s' < "$PWD"/set-up.sh
  echo "SET_UP=true" >> .env
fi

 cd ../ && go build -o alpineConfig
rsync -arv ./alpineConfig "$USER"@"$LINODE_IP":"$DIR"
ssh "$USER"@"$LINODE_IP" 'cd "/home/root/" && alpineConfig'

