#!/bin/bash

if [ $# -gt 0 ]; then
  if [ $1 == "test" ] || [ $1 == "beta" ] || [ $1 == "release" ]; then
    cmdpath=$helperpath/cmds/build
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