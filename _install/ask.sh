#!/bin/sh
ask() {
    read -p "$1 [y/N] " res
    res=$(echo "$res" | tr '[:upper:]' '[:lower:]')
    local -n ref=$2
    ref=false 
    if [ "$res" = "y" ]; then
        ref=true
    else
        ref=false
    fi
}

response=false
ask "Is this true" response
echo $response

