#!/bin/bash

rsync_omz=1

if [ ! -f "/usr/bin/rsync" ]; then 
    echo "[$0] rsync is not installed. Unable to sync ./oh-my-zsh/ config"
    rsync_omz=0
fi

echo "~/.zshrc -> ~/.zshrc{,.pre-koeir-config}"
echo "./zshrc -> ~/.zshrc"
cp ~/.zshrc{,.pre-koeir-config}
cp ./zshrc ~/.zshrc

fzfconfigdir="$HOME/.config/fzf/koeir"
if [ ! -d "$fzfconfigdir" ]; then
    echo "mkdir $fzfconfigdir"
    if ! mkdir -p $fzfconfigdir; then
        echo "exiting script"
        exit
    fi
fi

echo "./config/fzf/koeir/* -> $fzfconfigdir"
cp ./config/fzf/koeir/* $fzfconfigdir

omzdir="$HOME/.oh-my-zsh"
if [[ $rsync_omz -eq 1 ]]; then
    if [ ! -d "$omzdir" ]; then
        echo "${omzdir}: Directory not found"
    fi

    echo "./oh-my-zsh -> ~/.oh-my-zsh.bak"
    rsync -r ${omzdir}{,.bak}
    echo "rsync -rv ./oh-my-zsh/* $omzdir"
	rsync -r ./oh-my-zsh/* $omzdir
fi
