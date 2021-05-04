#!/bin/bash

# Setup Environment for ssh-agent
test -n "$SSH_AGENT_PID" && echo \
"SSH_AGENT_PID=$SSH_AGENT_PID; \
export SSH_AGENT_PID" > ~/.agent_info

test -n "$SSH_AUTH_SOCK" && echo \
"SSH_AUTH_SOCK=$SSH_AUTH_SOCK; \
export SSH_AUTH_SOCK" >>  ~/.agent_info

# Load the Private Keys into the running SSH Agent
if [ $LOGNAME = "henri" ]
then
  # pid=`ps | grep ssh-agent | grep -v grep`
  pid=$SSH_AGENT_PID
  echo "pid=$pid"
  if [ "$pid" != "" ]
  then
    if /usr/bin/tty 1> /dev/null 2>&1
    then
      # ssh-add 1> /dev/null 2>&1
      #ssh-add ~/.ssh/manjaroGit
      echo 'here'  
    fi
  fi
fi
