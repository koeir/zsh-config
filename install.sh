#!/bin/bash

doRsync=true
HOME_OMZ="$HOME/.oh-my-zsh"
HOME_CONFIG_FZF="$HOME/.config/fzf"
SCRIPT_DIR="$(dirname "$0")"
THIS_OMZ="$SCRIPT_DIR/oh-my-zsh"

RED="\033[31m"
NC="\033[0m"

if ! command -v rsync &>/dev/null; then 
    echo "[$0] rsync is not installed. Unable to sync "$SCRIPT_DIR"/oh-my-zsh/ config"
    doRsync=false
fi

# Copy zshrc
echo -e "${RED}Copying zshrc...${NC}" && sleep 3
echo "~/.zshrc => ~/.zshrc{,.pre-koeir-config}"
echo "./zshrc -> ~/.zshrc"
cp ~/.zshrc{,.pre-koeir-config}
cp "$SCRIPT_DIR/zshrc" "$HOME/.zshrc"

if [ ! -d "$HOME_CONFIG_FZF" ]; then
    echo "mkdir $HOME_CONFIG_FZF"
    if ! mkdir -p $HOME_CONFIG_FZF; then
        echo "exiting script"
        exit 1
    fi
fi

echo ""
echo -e "${RED}Copying fzf preview config...${NC}" && sleep 3
# fzf preview config
echo "./config/fzf/koeir/* -> $HOME_CONFIG_FZF"
if $doRsync; then
    rsync -a "$SCRIPT_DIR/config/fzf/koeir" "$HOME_CONFIG_FZF"
else
    cp -r "$SCRIPT_DIR/config/fzf/koeir" "$HOME_CONFIG_FZF"
fi

echo ""
echo -e "${RED}Backing up oh-my-zsh directory...${NC}" && sleep 3
# backup HOME_OMZ first
echo "./oh-my-zsh => ~/.oh-my-zsh.pre-koeir"
if $doRsync; then
    if ! rsync -a ${HOME_OMZ}{/*,.pre-koeir} --delete; then
        echo "exiting script"
        exit 1
    fi
else
    if ! cp -r ${HOME_OMZ}{,.pre-koeir}; then
        echo "exiting script"
        exit 1
    fi
fi

# show diff omz files
while IFS= read -r line; do
    [[ -n "$(xargs <<< "$line")" ]] && echo "info: $line"
done <<< $(diff -rq "$THIS_OMZ" "$HOME_OMZ" | grep -v '^Only in')

# sync omz
echo ""
echo -e "${RED}Syncing oh-my-zsh directories${NC}" && sleep 3
echo "info: make sure that gitmodules have been initialized and updated"
echo "info: some files may be overwritten"
if $doRsync; then
    if [ ! -d "$HOME_OMZ" ]; then
        echo "${HOME_OMZ}: Directory not found"
    fi

    echo "> rsync -a $THIS_OMZ $HOME_OMZ"
	rsync -a "$THIS_OMZ" "$HOME_OMZ" \
        --exclude="*.md"
fi

echo ""
echo "don't forget to source!"
