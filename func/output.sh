#!/bin/bash

# prepare nice debugging colors
###########################################
function show_error() {
    echo -e "\e[31m$1\e[0m"
}
function show_success() {
    echo -e "\e[32m$1\e[0m"
}
function show_warning() {
    echo -e "\e[33m$1\e[0m"
}
