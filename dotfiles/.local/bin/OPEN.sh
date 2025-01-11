#!/bin/sh

run_command() {
    if [ -z "$1" ]; then
        echo "Usage: run_command '<command>'"
        return 1
    fi

    eval $1
}
run_command $1
