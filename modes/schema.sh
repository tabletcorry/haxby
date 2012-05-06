#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register schema
haxby::modes::help::register "schema: Various schema tools"

function haxby::modes::help::schema {
    haxby::core::modes::run-with-submodes schema help $@
}

function haxby::modes::schema {
    haxby::core::modes::run-with-submodes schema $@
}

