#!/bin/bash

HAXBY_MODES="$HAXBY_MODES stop"

function haxby::lib::stop {

cd $HAXBY_DATA

pg_ctl stop -m immediate

}
