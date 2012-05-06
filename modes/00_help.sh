#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

if [ -z "$HAXBY_HELP_COMMAND_NAME" ]
    HAXBY_HELP_COMMAND_NAME=haxby
fi

HAXBY_MODES="$HAXBY_MODES help"

HAXBY_HELP="usage: $HAXBY_HELP_COMMAND_NAME <command> [<args>]\n\n\
The available $HAXBY_HELP_COMMAND_NAME commands are:"

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

