#!/bin/echo "Do not run this directly"

[[ -z "$HAXBY_TMP" ]] && HAXBY_TMP=/tmp/haxby
[[ ! -d "$HAXBY_TMP" ]] && mkdir $HAXBY_TMP

export PG_CONTRIB=$(pg_config --sharedir)/contrib
export PGDATA=pgdata
export PGLOG=pglog

HAXBY_MODES="help"

function haxby::help {
    echo "HELP!"
}

. $HAXBY_LIB/init.sh
. $HAXBY_LIB/new-db.sh
. $HAXBY_LIB/start.sh
. $HAXBY_LIB/stop.sh
. $HAXBY_LIB/cleanup.sh
