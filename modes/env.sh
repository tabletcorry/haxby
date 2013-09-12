#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register env
haxby::modes::help::register "env: Print haxby's internal environment"

function haxby::modes::help::env {
    echo "usage: haxby env [PATTERN]"
    echo -e "\ndescription:"
    echo "Print the environment that haxby has loaded at mode start"
    echo "Optionally, a pattern to select from the environment"
}

function haxby::modes::env {
    environment=$(env)
    if [[ -n "$1" ]]; then
        environment=$(grep $1 <<<"$environment")
    fi

    echo "$environment"
}
