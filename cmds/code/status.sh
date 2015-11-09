#!/bin/bash
source $cmdpath/options.inc.sh

if [[ $verbose ]]; then
    echo ""
    show_warning "Checking custom repository status..."
    echo ""
fi
repo status
