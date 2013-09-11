#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register daemontools
haxby::modes::help::register "daemontools: Install it"

function haxby::modes::help::install::daemontools {
    #TODO
    echo "Docs not written yet"
}

function haxby::modes::install::daemontools {
    cd $HAXBY_DATA

    DT_URL='http://cr.yp.to/daemontools/daemontools-0.76.tar.gz'
    DT_SHA='70a1be67e7dbe0192a887905846acc99ad5ce5b7'
    
    if [ -n "$1" ]; then
        # Allow alternate install sources
        :
    fi

}
