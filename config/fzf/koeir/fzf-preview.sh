#!/usr/bin/env bash
#
# The purpose of this script is to demonstrate how to preview a file or an
# image in the preview window of fzf.
#
# Dependencies:
# - https://github.com/sharkdp/bat
# - https://github.com/hpjansson/chafa
# - https://iterm2.com/utilities/imgcat

if [[ $# -ne 1 ]]; then
  >&2 echo "usage: $0 FILENAME[:LINENO][:IGNORED]"
  exit 1
fi

file=${1/#\~\//$HOME/}

center=0
if [[ ! -r $file ]]; then
  if [[ $file =~ ^(.+):([0-9]+)\ *$ ]] && [[ -r ${BASH_REMATCH[1]} ]]; then
    file=${BASH_REMATCH[1]}
    center=${BASH_REMATCH[2]}
  elif [[ $file =~ ^(.+):([0-9]+):[0-9]+\ *$ ]] && [[ -r ${BASH_REMATCH[1]} ]]; then
    file=${BASH_REMATCH[1]}
    center=${BASH_REMATCH[2]}
  fi
fi

type=$(file --brief --dereference --mime -- "$file")

if [[ ! $type =~ image/ ]]; then
  if [[ $type =~ =binary ]]; then
    file "$1"
    exit
  fi


bat --style="${BAT_STYLE:-numbers}" --color=always --pager=never --highlight-line="${center:-0}" -- "$file"

dim=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}
if [[ $dim == x ]]; then
  dim=$(stty size < /dev/tty | awk '{print $2 "x" $1}')
elif ! [[ $KITTY_WINDOW_ID ]] && ((FZF_PREVIEW_TOP + FZF_PREVIEW_LINES == $(stty size < /dev/tty | awk '{print $1}'))); then
  # Avoid scrolling issue when the Sixel image touches the bottom of the screen
  # * https://github.com/junegunn/fzf/issues/2544
  dim=${FZF_PREVIEW_COLUMNS}x$((FZF_PREVIEW_LINES - 1))
fi

timg -g"$dim" "$file"

# Cannot find any suitable method to preview the image
else
  file "$file"
fi
