#!/bin/bash

HAXBY_MODES="$HAXBY_MODES start"

function haxby::lib::start {

cd $HAXBY_DATA

pg_ctl -l $PGLOG -w start

}
