#!/bin/bash

cd $PWD
verbose=1
helperpath="$(cd "$(dirname "${BASH_SOURCE[0]}")"&&pwd)"/..
source $helperpath/lib/output.sh
source $helperpath/config/settings.sh
product=$settings_default_product
recoverypath=$helperpath/device/$product/recovery
if [ $use_archfix ]; then
    source $helperpath/inc/archfix.sh
fi

# parse options
###########################################
function show_usage {
  echo -e "
 \e[1mUsage: quickbuild <command> <subcommand> [options]\e[0m


COMMANDS:

build               build rom/recovery/kernel
-----
    SUBCOMMANDS:
    test            make a test quick build (no clean, include gapps)   [version: x.y.z+1]
    beta            make a beta release (no clean, no gapps)            [version: x.y+1.0]
    release         make a release build (full clean, no gapps)         [version: x+1.0.0]
        OPTIONS:
        -u          build is a kernel update (increase kernel version)
        -k          pack kernel
        -c          pack recovery
        -v          verbose

flash               flash files from releases/last/ dir
-----
    SUBCOMMANDS:
    all             flash rom, recovery and kernel
    rom             flash rom
    recovery        flash recovery
    kernel          flash kernel
        OPTIONS:
        -a          use adb instead of fastboot [recovery only]
        -s          silent

clean               clean build dir
-----
    SUBCOMMANDS:
    all             'make clean'
    quick           just cleanup some basic stuff
    recovery        cleanup recovery related things
    kernel          cleanup kernel related things
        OPTIONS:
        -s          silent

code                automated code-management
-----
    SUBCOMMANDS:
    full            update, sync, merge and push all repos
    sync            update all non-custom repos
    merge           merge all custom repos from upstream remote
    push            push all custom repos to private remote
    status          show status of all custom repos
        OPTIONS:
        -s          silent

  "
}

if [ $# -gt 0 ]; then
  if [ $1 == "build" ] || [ $1 == "flash" ] || [ $1 == "clean" ] || [ $1 == "code" ]; then
    script=$1
    shift
    source $helperpath/cmds/$script.sh $@
  else
    echo "Unknown command: $1"
    show_usage
    exit 1
  fi
else
  show_usage
  exit 1
fi
