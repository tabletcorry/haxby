#!/bin/bash

HAXBY_MODES="$HAXBY_MODES help"

HAXBY_HELP="usage: haxby <command> [<args>]\n\n\
The available haxby commands are:"

function haxby::modes::help::register {
    HAXBY_HELP="$HAXBY_HELP\n    $*"
}

function haxby::modes::help {
    if [[ -n "$1" ]]
    then
        haxby::modes::help::$1
    else
        echo -e "$HAXBY_HELP"
    fi
}

