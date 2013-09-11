#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register install
haxby::modes::help::register "install: Install what you need"

function haxby::modes::help::install {
    haxby::core::modes::run-with-submodes install help $@
}

function haxby::modes::install {
    haxby::core::modes::run-with-submodes install $@
}

