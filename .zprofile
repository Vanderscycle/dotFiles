#ssh
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval "ssh-agent -s"
  ssh-add ~/.ssh/manjaroGit
fi
#gpg
echo "test" | gpg2 --clearsign
echo RELOADAGENT | gpg-connect-agent  
export GPG_TTY=$TTY
