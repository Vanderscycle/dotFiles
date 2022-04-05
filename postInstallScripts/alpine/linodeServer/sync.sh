#!/bin/bash

# load the secrets for this script
if [ -f .env ]
then
  source .env
else
    echo "[MISSING] : missing .env file" 
    exit 125
fi

DIR='/home/$USER/maas'
LOCAL_DIR="/home/henri/Documents/maas-landing-page"

# rsync -av ./set-up.sh "$USER"@"$LINODE_IP":/home/"$USER"/ #TODO: rsync won't work until you actually update the server
# chmod +x *.sh

(cd "$LOCAL_DIR" && git archive --format=tar.gz -o "$LOCAL_DIR"/maas-latest.tar.gz HEAD) #  --prefix=maas/

#configure the env (arch but can be debian)
# https://stackoverflow.com/questions/305035/how-to-use-ssh-to-run-a-local-shell-script-on-a-remote-machine

# ssh "$USER"@"$LINODE_IP" 'bash -s' < ~/Documents/maas-landing-page/linode-server/set-up.sh

declare -a StringArray=("backend" "frontend")
for SECRET in "${StringArray[@]}"; do
  rsync -arv "$LOCAL_DIR"/"$SECRET"/.env "$USER"@"$LINODE_IP":"$DIR"/"$SECRET"
done

rsync -arv "$LOCAL_DIR"/maas-latest.tar.gz "$USER"@"$LINODE_IP":"$DIR"

ssh "$USER"@"$LINODE_IP" 'cd "/home/root/maas/" && tar -xvf maas-latest.tar.gz && podman-compose up -d'
#BUG: podman-compose has this piece of shit error that I can't fucking fix/ so I am using docker for now


