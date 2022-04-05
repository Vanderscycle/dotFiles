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
echo $DIR $LOCAL_DIR

if [ ! -n $SET_UP]
then
  rsync -av ./set-up.sh "$USER"@"$LINODE_IP":/home/"$USER"/
  ssh "$USER"@"$LINODE_IP" 'bash -s' < "$PWD"/set-up.sh
fi

( cd ../"$LOCAL_DIR" && go build alpineConfig)
rsync -arv ../"$LOCAL_DIR"/alpineConfig "$USER"@"$LINODE_IP":"$DIR"

ssh "$USER"@"$LINODE_IP" 'cd "/home/root/" && alpineConfig'


