#!/bin/bash
source $cmdpath/options.sh

if [[ $verbose ]]; then
    echo ""
    show_warning "Kernel cleanup..."
    echo ""
fi

source $helperpath/lib/clean.sh
clean_kernel $product
