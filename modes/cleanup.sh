#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register cleanup
haxby::modes::help::register "cleanup: Stop cluster and destroy data files"

function haxby::modes::help::cleanup {
    echo "usage: haxby cleanup"
    cecho "*** WARNING: This will permanently destroy data" $BG_RED -n
    echo -e "\ndescription:"
    echo "cleanup immediately stops the postgres cluster and deletes all of 
the data associated with it"
}

function haxby::modes::cleanup {
    haxby::core::fail-in-production

    cd $HAXBY_DATA

    pg_ctl stop -m immediate
    rm -r $PGDATA $PGLOG
}
