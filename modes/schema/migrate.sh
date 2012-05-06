#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register migrate
haxby::modes::help::register "migrate: Migrates the database to a newer schema version"

function haxby::modes::help::migrate {
    # TODO actually describe the args
    echo "usage: haxby migrate [<args>]"
    echo -e "\ndescription:"
    echo "Migrates the database to a newer schema version"
}

function haxby::modes::migrate {
    # TODO implement
    echo Not implemented!
    echo $@
}

