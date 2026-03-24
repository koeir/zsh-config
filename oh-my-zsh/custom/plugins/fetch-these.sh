#!/bin/bash

for dir in ./*; do
    if [ ! -d "${dir}/.git" ]; then
        continue;
    else
        git -C "$dir" fetch -v
    fi
done

git status
