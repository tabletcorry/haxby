#!/bin/bash

haxby::core::modes::register stop
haxby::modes::help::register "stop: Stop the database cluster"

function haxby::modes::stop {
    cd $HAXBY_DATA

    pg_ctl stop -m immediate
}
