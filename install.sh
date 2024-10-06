#!/usr/bin/env bash

if [ $(id -u) -ne 0 ]; then
    echo "sudo is required, before launch check the file!"
    exit 1
fi

apt install ripgrep universal-ctags -y
