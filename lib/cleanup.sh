#!/bin/bash

HAXBY_MODES="$HAXBY_MODES clean"

function haxby::clean {

cd $HAXBY_DATA

pg_ctl stop -m immediate

rm -r $PGDATA $PGLOG

}
