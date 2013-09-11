#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

HAXBY_HELP_COMMAND_NAME="haxby install"
. "$HAXBY_ROOT/modes/00_help.sh"

function haxby::modes::install::help {
    [[ -n "$1" ]] && help_name="install::$1"
    haxby::modes::help $help_name
}

