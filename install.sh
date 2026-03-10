#!/bin/bash

sync_omz=true

if [ ! -f "/usr/bin/rsync" ]; then 
    echo "[$0] rsync is not installed. Unable to sync ./oh-my-zsh/ config"
    sync_omz=false
fi

cp ~/.zshrc{,.pre-koeir-config}
cp ./zshrc ~/.zshrc

if [[ $rsync_omz == "true" ]]; then
	rsync -rv ./oh-my-zsh/* ~/.oh-my-zsh
fi
