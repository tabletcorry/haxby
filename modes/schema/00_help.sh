#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

HAXBY_HELP_COMMAND_NAME="haxby schema"
. "$HAXBY_ROOT/modes/00_help.sh"

function haxby::modes::schema::help {
    [[ -n "$1" ]] && help_name="schema::$1"
    haxby::modes::help $help_name
}

