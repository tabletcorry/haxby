#!/bin/bash

HAXBY_MODES="$HAXBY_MODES clean"

function haxby::clean {

pg_ctl stop -m immediate

rm -r $PGDATA $PGLOG

}
