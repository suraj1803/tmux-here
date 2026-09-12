#!/usr/bin/env bash

test() {
    local dir="${1:-.}"

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

test $1
