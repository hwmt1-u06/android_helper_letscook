#!/bin/bash
cd $PWD

if [ -e letscook ]; then
    rm letscook
    echo "Symlink removed."
fi

echo "OK. Bye!"
exit 0
