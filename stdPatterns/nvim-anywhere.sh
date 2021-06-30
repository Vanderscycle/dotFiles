#!/bin/bash
#
# vim-anywhere - use Vim whenever, wherever
# Author: Chris Knadler
# Homepage: https://www.github.com/cknadler/vim-anywhere
#
# Open a temporary file with Vim. Once Vim is closed, copy the contents of that
# file to the system clipboard.

###
# defs
###

err() { echo -e "$@" 1>&2; }

require_file_exists() {
  if [ ! -e $1 ]; then
    err "$1 does not exist. ${@:2}"
    exit 1
  fi
}

###
# opts
###

while getopts ":t:v" opt; do
  case "$opt" in
    t) LAUNCH_TERM=$OPTARG ;;
    v) set -x ;;
    \?) echo "Invalid option: -$OPTARG" >&2 ;;
    :) echo "Option -$OPTARG requires an argument" >&2 ;
  esac
done

###
# run
###

AW_PATH=$HOME/.vim-anywhere
TMPFILE_DIR=/tmp/vim-anywhere
TMPFILE=$TMPFILE_DIR/doc-$(date +"%y%m%d%H%M%S")
VIM_OPTS=--nofork

# Use ~/.gvimrc.min or ~/.vimrc.min if one exists
VIMRC_PATH=($HOME/.gvimrc.min $HOME/.vimrc.min)

for vimrc_path in "${VIMRC_PATH[@]}"; do
    if [ -f $vimrc_path ]; then
        VIM_OPTS+=" -u $vimrc_path"
        break
    fi
done

mkdir -p $TMPFILE_DIR
touch $TMPFILE

# Linux
if [[ $OSTYPE == "linux-gnu" ]]; then
  chmod o-r $TMPFILE # Make file only readable by you
  if [[ "" != "$LAUNCH_TERM" ]]; then
	  $LAUNCH_TERM -e nvim $VIM_OPTS $TMPFILE
  else 
	  nvim  $TMPFILE #VIM_OPTS #to figure out
  fi
  cat $TMPFILE | xclip -selection clipboard
