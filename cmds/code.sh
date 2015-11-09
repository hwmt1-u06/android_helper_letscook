#!/bin/bash

if [ $# -gt 0 ]; then
  if [ $1 == "full" ] || [ $1 == "sync" ] || [ $1 == "merge" ] || [ $1 == "status" ]; then
    cmdpath=$helperpath/cmds/code
    source $cmdpath/$1.sh
  else
    echo "Unknown subcommand: $1"
    show_usage
    exit 1
  fi
else
  show_usage
  exit 1
fi