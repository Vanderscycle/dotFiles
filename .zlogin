# services 

#SSH
# https://wiki.archlinux.org/index.php/SSH_keys

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

bash ~/Documents/dotFiles/stdPatterns/sshkeychain.sh

#gpg

eval "keychain --eval --agents ssh ~/.ssh/manjaroGit"
#echo "test" | gpg2 --clearsign
#echo RELOADAGENT | gpg-connect-agent  
#export GPG_TTY=$TTY


# mounting drives
# https://unix.stackexchange.com/questions/297214/how-can-i-mount-usr-on-another-partition-but-use-a-folder-called-usr-on-that-p
