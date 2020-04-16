#!/bin/bash


function error_exit() {
  echo "$1" 1>&2
  exit 1
}

function check_deps() {
  test -f $(which git) || error_exit '{"error": "install git!"}'
  test -f $(which jq) || error_exit '{"error": "install jq!"}'
}
# Exit if any of the intermediate steps fail
set -e
check_deps
eval "$(jq -r '@sh "export DIR=\(.workdir) CLONEDIR=\(.clonedir) SSHGIT=\(.project_ssh) LOG=\(.logfile)"')"
echo "DIR: $DIR CLONEDIR: $CLONEDIR SSHGIT:$SSHGIT" >> $LOG
workdir=$DIR/$CLONEDIR
mkdir -p $workdir
cd $workdir
if $(git clone $SSHGIT 2>&1| tee -a $LOG) 
then 
    result=True
else
    result=False
fi
printf '{"%s":"%s"}\n' $(echo "${SSHGIT} ${result}")