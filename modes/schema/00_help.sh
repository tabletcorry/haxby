#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

HAXBY_HELP_COMMAND_NAME="haxby schema"
. "$HAXBY_ROOT/modes/00_help.sh"

function haxby::modes::schema::help {
  haxby::modes::help $@
}

