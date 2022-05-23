# services 

#SSH
# https://wiki.archlinux.org/index.php/SSH_keys
# https://unix.stackexchange.com/questions/554153/what-is-the-proper-configuration-for-gpg-ssh-and-gpg-agent-to-use-gpg-auth-sub
# https://unix.stackexchange.com/questions/396712/pinentry-not-showing-in-tmux
#ssh
#https://unix.stackexchange.com/questions/132065/how-do-i-get-ssh-agent-to-work-in-all-terminals
# https://www.jimmybonney.com/articles/load_ssh_keys_to_memory_with_ssh_agent/
#if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
#fi
#if [[ ! "$SSH_AUTH_SOCK" ]]; then
#    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
#fi

#bash ~/Documents/dotFiles/stdPatterns/sshkeychain.sh

#gpg

#eval "keychain --agents gpg,ssh --eval ~/.ssh/manjaroGit"
#echo "test" | gpg2 --clearsign
#echo RELOADAGENT | gpg-connect-agent  
#export GPG_TTY=$TTY


# mounting drives
# https://unix.stackexchange.com/questions/297214/how-can-i-mount-usr-on-another-partition-but-use-a-folder-called-usr-on-that-p
