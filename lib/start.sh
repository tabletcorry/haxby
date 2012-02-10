#!/bin/bash

HAXBY_MODES="$HAXBY_MODES start"

function haxby::start {

pg_ctl -l $PGLOG -w start

}
