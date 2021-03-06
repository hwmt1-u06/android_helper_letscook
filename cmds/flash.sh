#!/bin/bash

if [ $# -gt 0 ]; then
  if [ $1 == "all" ] || [ $1 == "rom" ] || [ $1 == "recovery" ] || [ $1 == "kernel" ]; then
    cmdpath=$helperpath/cmds/flash
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