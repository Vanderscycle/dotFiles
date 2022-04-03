#!/bin/bash

#https://www.linuxshelltips.com/install-go-alpine-linux/
cat > /etc/apk/repositories << EOF; $(echo)

https://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/main/
https://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community/
https://dl-cdn.alpinelinux.org/alpine/edge/testing/

EOF
