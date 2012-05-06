#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register schema
haxby::modes::help::register "schema: Various schema tools"

function haxby::modes::help::schema {
    echo "usage: haxby schema"
    cecho "*** WARNING: This will permanently destroy data" $BG_RED -n
    echo -e "\ndescription:"
    echo "Various schema tools."
    # TODO just run haxby schema help in a subshell
}

function haxby::modes::schema {
    submode=$1
    shift || true
    haxby::core::modes::use-mode-dir schema
    haxby::core::modes::run haxby::modes::schema "$submode"
}

