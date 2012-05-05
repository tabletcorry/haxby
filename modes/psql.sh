#!/bin/bash

haxby::core::modes::register psql
haxby::modes::help::register "psql: Run psql in this haxby environment"

function haxby::modes::help::psql {
    echo "usage: haxby psql [<args>]"
    echo -e "\ndescription:"
    echo "Runs psql inside this haxby environment"
}

function haxby::modes::psql {
    psql $@
}
