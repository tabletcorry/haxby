#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

if [[ -z "$HAXBY_HELP_COMMAND_NAME" ]]; then
    HAXBY_HELP_COMMAND_NAME=haxby
fi

haxby::core::modes::register help
haxby::core::modes::register_safemode help

HAXBY_HELP="usage: $HAXBY_HELP_COMMAND_NAME <command> [<args>]\n\n\
The available $HAXBY_HELP_COMMAND_NAME commands are:"

function haxby::modes::help::register {
    HAXBY_HELP="$HAXBY_HELP\n    $*"
}

haxby::modes::help::register "help: Print this help [safe]"

function haxby::modes::help {
    if [[ -n "$1" ]]
    then
        haxby::modes::help::$1
    else
        if [[ -n "$HAXBY_SAFEMODE" ]]
        then
            echo "*** Warning Haxby is in safemode, most command will not function"
            echo "*** Functions marked with [safe] will work"
        fi
        echo -e "$HAXBY_HELP"
    fi
}

