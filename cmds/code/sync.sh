#!/bin/bash
source $cmdpath/options.sh

if [[ $verbose ]]; then
    echo ""
    show_warning "Updating all repos..."
    echo ""
    repo sync -j$settings_threads > /dev/null
else
    repo sync -q -j$settings_threads > /dev/null
fi
