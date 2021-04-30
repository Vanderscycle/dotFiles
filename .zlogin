# https://unix.stackexchange.com/questions/297214/how-can-i-mount-usr-on-another-partition-but-use-a-folder-called-usr-on-that-p
# services 
#mopidy -q

#gpg

echo "test" | gpg2 --clearsign
echo RELOADAGENT | gpg-connect-agent  
export GPG_TTY=$TTY
