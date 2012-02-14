#!/bin/bash

HAXBY_MODES="$HAXBY_MODES clean"

function haxby::lib::clean {

cd $HAXBY_DATA

pg_ctl stop -m immediate

rm -r $PGDATA $PGLOG

}
