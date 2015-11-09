#!/bin/bash
source $cmdpath/options.inc.sh
source $helperpath/func/clean.sh

if [[ $verbose ]]; then
    echo ""
    show_warning "Kernel cleanup..."
    echo ""
fi

clean_kernel $product
