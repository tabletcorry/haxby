#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register stop
haxby::modes::help::register "stop [-f]: Stop the database cluster"

function haxby::modes::stop {
    force=$1

    if [[ "$force" != "-f" ]]; then
        haxby::core::fail-in-production
    fi

    cd $HAXBY_DATA

    pg_ctl stop -m immediate
}
