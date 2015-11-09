#!/bin/bash
source $cmdpath/options.inc.sh
source $helperpath/func/clean.sh

if [[ $verbose ]]; then
    echo ""
    show_warning "Quick cleanup..."
    echo ""
fi

clean_quick $product
