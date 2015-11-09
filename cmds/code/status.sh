#!/bin/bash
source $cmdpath/options.sh

if [[ $verbose ]]; then
    echo ""
    show_warning "Checking custom repository status..."
    echo ""
fi
repo status
