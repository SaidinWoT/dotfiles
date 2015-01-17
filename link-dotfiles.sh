#!/bin/sh
for file in ~/.dotfiles/*; do
    filename=$(basename $file)
    if [ $filename != "README.md" -a $filename != $(basename ${0}) ]
    then
        ln -s $file ~/.$filename
    fi
done
