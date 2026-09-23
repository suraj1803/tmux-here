#!/usr/bin/env bash

tm() {
    local dir

    if [[ -z "$1" ]]; then
        dir=$(find ~ -type d \( -name .git -o -name node_modules -o -name .cache \) -prune -o -type d -print 2>/dev/null | fzf --prompt="Enter directory> " --height=40% --reverse)

        [[ -z "$dir" ]] && return 0
    else
        dir="$1"
    fi

    if [[ ! -d "$dir" ]]; then
        echo "no such folder $1"
        return 1;
    fi

    dir=$(realpath "$dir") 

    # For DEBUG
    echo "$dir"

    local name=$(basename "$dir")

    # For DEBUG 
    echo "$name"

    tmux has-session -t "$name" 2>/dev/null || tmux new-session -d -s "$name" -c "$dir"

    if [[ -n $TMUX ]]; then
        tmux switch-client -t "$name"
    else
        tmux attach-session -t "$name"
    fi
}
