#!/bin/bash

haxby::core::modes::register reload
haxby::modes::help::register "reload: re-initialize database and attempt to save existing data"

function haxby::modes::reload {
    haxby::modes::init reload
}
