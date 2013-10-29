#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register conf
haxby::modes::help::register "conf: Print a sample conf file"

function haxby::modes::help::conf {
    echo "usage: haxby conf"
    echo "Print a sample config file for haxby. Put this in your project."
}

function haxby::modes::conf {
        cat $HAXBY_MODE_DIR/templates/haxby.conf
}
