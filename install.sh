#!/bin/bash

rsyncOmz=true

if ! command -v rsync; then 
    echo "[$0] rsync is not installed. Unable to sync ./oh-my-zsh/ config"
    rsyncOmz=false
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
        exit 1
    fi
fi

echo "./config/fzf/koeir/* -> $fzfconfigdir"
cp ./config/fzf/koeir/* $fzfconfigdir

# backup omzdir first
echo "./oh-my-zsh -> ~/.oh-my-zsh.pre-koeir"
if $rsyncOmz; then
    if ! rsync -r ${omzdir}{/*,.pre-koeir} --delete; then
        echo "exiting script"
        exit 1
    fi
else
    if ! cp -r ${omzdir}{,.pre-koeir}; then
        echo "exiting script"
        exit 1
    fi
fi

omzdir="$HOME/.oh-my-zsh"
if $rsyncOmz; then
    if [ ! -d "$omzdir" ]; then
        echo "${omzdir}: Directory not found"
    fi

    echo "rsync -rv ./oh-my-zsh/* $omzdir"
	rsync -r ./oh-my-zsh/* $omzdir --delete
fi

echo ""
echo "don't forget to source!"
