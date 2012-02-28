#!/bin/bash

HAXBY_MODES="$HAXBY_MODES clean"

function haxby::modes::clean {

cd $HAXBY_DATA

pg_ctl stop -m immediate

rm -r $PGDATA $PGLOG

}
