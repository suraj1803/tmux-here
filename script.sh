#!/usr/bin/env bash

tm() {
    local dir

    if [[ -z "$1" ]]; then
        dir=$(find ~ -type d \( -name .git -o -name node_modules -o -name .cache \) -prune -o -type d -print 2>/dev/null | fzf --prompt="Enter directory> " --height=40% --reverse)

        [[ -z "$dir" ]] && return 0
    else
        if [[ "$1" == "ls" ]]; then
            local tmux_sessions=$(tmux ls 2>/dev/null | awk -F: '{print $1}')

            if [[ "$tmux_sessions" == "" ]]; then
                echo "No tmux sessions found."
                return 1
            fi

            local selected_session=$(echo "$tmux_sessions" | fzf --prompt="Select tmux session> " --height=40% --reverse)

            [[ -z "$selected_session" ]] && return 0

            if [[ "$selected_session" == ":q" ]]; then
                return 0
            fi


            if [[ -n $TMUX ]]; then
                tmux switch-client -t "$selected_session"
            else
                tmux attach-session -t "$selected_session"
            fi

            return 0
        fi

        dir="$1"
    fi

    if [[ ! -d "$dir" ]]; then
        echo "no such folder $1"
        return 1
    fi

    dir=$(realpath "$dir")

    local name=$(basename "$dir")

    tmux has-session -t "$name" 2>/dev/null || tmux new-session -d -s "$name" -c "$dir"

    if [[ -n $TMUX ]]; then
        tmux switch-client -t "$name"
    else
        tmux attach-session -t "$name"
    fi
}
