#!/bin/echo "Do not run this directly"

[[ -z "$HAXBY_TMP" ]] && HAXBY_TMP=/tmp/haxby
[[ ! -d "$HAXBY_TMP" ]] && mkdir $HAXBY_TMP

[[ -z "$HAXBY_DATABASE_D" ]] && HAXBY_DATABASE_D=./databases
[[ -z "$HAXBY_DATA" ]] && HAXBY_DATA=./pg
[[ ! -d "$HAXBY_DATA" ]] && mkdir $HAXBY_DATA

[[ -z "$PG_CONTRIB" ]] && PG_CONTRIB=$(pg_config --sharedir)/contrib
[[ -z "$PGDATA" ]] && PGDATA=pgdata
[[ -z "$PGLOG" ]] && PGLOG=pglog

export PG_CONTRIB
export PGDATA
export PGLOG

HAXBY_MODES="help"

. $HAXBY_LIB/init.sh
. $HAXBY_LIB/new-db.sh
. $HAXBY_LIB/start.sh
. $HAXBY_LIB/stop.sh
. $HAXBY_LIB/cleanup.sh

function haxby::lib::help {
    echo "HELP!"
    echo "Known modes: $HAXBY_MODES"
}
