pathadd() {
    local usage="[$0] Usage: $0 [append/prepend] <path-to-directory>"
    
    if [[ "$#" != 2 ]]; then
        echo "[$0] Missing argument"
        echo "$usage"
        return 1
    fi

    if [ ! -d "$2" ]; then
        echo "[$0] Directory $2 not found."
        return 1
    fi

    if [[ ":$PATH:" == *":$2:"* ]]; then 
        return 1
    fi

    if [[ "$1" == "append" ]]; then
        PATH="${PATH:+"$PATH:"}$2"
        return 0
    elif [[ "$1" == "prepend" ]]; then
        PATH="${2}${PATH:+":$PATH"}"
        return 0
    else
        echo "[$0] Option $1 not found."
        echo "$usage"
        return 1
    fi

    return 2
}

fzd() {
    if ! command -v fzf &> /dev/null; then
        echo "[$0] fzf is not installed."
        return
    fi

    if [ ! -z "$1" ]; then
        cd "$(find "$1" -type d | fzf --style full --no-preview)"
    else
        cd "$(find . -type d | fzf --style full --no-preview)"
    fi

    return 0
}

fzv() {
    local file="$1"

    # If no arg given, fzf
    if [ -z "$1" ]; then
        file="$(fzf)"
    else
        file="$(find . -type f -name "*$file*")"
    fi

    if [ "$(wc -l <<< "$file")" -gt 1 ]; then
        file="$(fzf <<< "$file")"
    fi

    if [ -z "$file" ]; then
        echo "[$0] '$1': No such file"
        return 1
    fi

    if [ ! -f "$file" ]; then
        echo "[$0] '$file': Not a file"
        return 1
    fi

    nvim "$file"
    echo "[$0] $file"

    return 0
}

cls() {
  printf "\033[H\033[1;1H"           # Move to top-left
  printf "\033[0J"                    # Clear from cursor down
  printf "\033[%s;1H" "$((LINES-1))"  # Move cursor to second-to-last line
}
