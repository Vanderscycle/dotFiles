#ssh
#https://unix.stackexchange.com/questions/132065/how-do-i-get-ssh-agent-to-work-in-all-terminals
export SSH_AUTH_SOCK=~/.ssh/ssh-agent.$HOSTNAME.sock
ssh-add -l 2>/dev/null >/dev/null
if [ $? -ge 2 ]; then
  ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
fi
#if [ -z "$SSH_AUTH_SOCK" ] ; then
#  eval "ssh-agent -s"
#  ssh-add ~/.ssh/manjaroGit
#fi
#
