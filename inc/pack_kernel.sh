#!/bin/bash

# pack kernel?
###########################################
if [ $kernel ] && [ -f out/target/product/$product/kernel ]; then

    # TODO FIXME
    show_error "Kernel packing not implemented yet."
fi
