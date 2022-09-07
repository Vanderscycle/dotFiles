#!/bin/sh

main () {
  if [[ -n "$1" ]];then
    IP="$1"
  else
    IP="192.168.1.51"
  fi
  echo -e "$IP"
  ssh-keygen -R "$IP"
  rsync ./microk8s.sh pi@{"$IP"}:~/
}
# main()
#pi@192.168.1.51
