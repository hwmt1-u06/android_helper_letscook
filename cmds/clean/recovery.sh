#!/bin/bash
source $cmdpath/options.inc.sh
source $helperpath/func/clean.sh

if [[ $verbose ]]; then
    echo ""
    show_warning "Recovery cleanup..."
    echo ""
fi

clean_recovery $product
