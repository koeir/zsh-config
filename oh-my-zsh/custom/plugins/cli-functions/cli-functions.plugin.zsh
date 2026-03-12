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
        cd "$(find . -type d | fzf)"
    fi

    return 0
}
