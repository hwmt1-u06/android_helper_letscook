#!/bin/bash

# Save build numbers for auto increase
echo "$release_number_major" > $helperpath/config/.last_release
echo "$release_number_minor" > $helperpath/config/.last_release_minor
echo "$build_number" > $helperpath/config/.last_build
if [[ $kernel_update ]]; then
    echo "$kernel_version" > $helperpath/config/.last_kernel
fi