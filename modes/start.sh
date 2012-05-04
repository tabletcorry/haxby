#!/bin/bash

haxby::core::modes::register start
haxby::modes::help::register "start: Start the database cluster"

function haxby::modes::start {
    cd $HAXBY_DATA

    pg_ctl -l $PGLOG -w start
}
