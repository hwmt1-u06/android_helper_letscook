#!/bin/bash
source $cmdpath/options.sh

if [[ $verbose ]]; then
    echo ""
    show_warning "Recovery cleanup..."
    echo ""
fi

source $helperpath/lib/clean.sh
clean_recovery $product
