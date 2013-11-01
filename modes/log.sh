#!/bin/bash

haxby::core::modes::register log
haxby::modes::help::register "log [-lf]: Tail the postgres log"

function haxby::modes::help::log {
    echo "usage: haxby psql [-lf]"
    echo "-l: Just show the file name"
    echo "-f: Follow the log file"
    echo "tail the postgres log file"
}

function haxby::modes::log {
    if [[ "$1" == "-f" ]]
    then
        tail -f $PGLOG
    elif [[ "$1" == "-l" ]]
    then
        echo $PGLOG
    else
        tail $PGLOG
    fi
}
