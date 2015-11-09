#!/bin/bash
cd $PWD
helperpath="$(cd "$(dirname "${BASH_SOURCE[0]}")"&&pwd)"
source $helperpath/lib/output.sh

if [ -e letscook ]; then
    rm letscook
    show_success "Symlink for letscook removed."
fi

if [ -e /etc/bash_completion.d/letscook.sh ]; then
    sudo rm /etc/bash_completion.d/letscook.sh
    show_success "Bash auto_completion script for 'cook' uninstalled."
fi

echo "OK. Bye!"
exit 0
