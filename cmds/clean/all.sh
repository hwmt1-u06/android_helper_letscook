#!/bin/bash
source $cmdpath/options.inc.sh

if [[ $verbose ]]; then
    echo ""
    show_warning "Wiping out-directory..."
    echo ""
fi

make clean > /dev/null
