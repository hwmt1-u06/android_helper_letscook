#!/bin/bash
source $cmdpath/options.sh

if [[ $verbose ]]; then
    echo ""
    show_warning "Quick cleanup..."
    echo ""
fi

source $helperpath/lib/clean.sh
clean_quick $product
