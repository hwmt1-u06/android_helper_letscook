#!/bin/bash

# copy a file and generate a md5 file for it
###########################################
function copywmd5() {
    cp -f $1 $2
    md5=`md5sum $2`
    echo $md5 >$2.md5
    echo $md5
}
