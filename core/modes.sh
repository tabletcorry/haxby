#!/bin/echo "Do not run this directly"

function haxby::core::defaults {

[[ -z "$HAXBY_TMP" ]] && HAXBY_TMP=/tmp/haxby
[[ ! -d "$HAXBY_TMP" ]] && mkdir $HAXBY_TMP

[[ -z "$HAXBY_DATABASE_D" ]] && HAXBY_DATABASE_D=$HAXBY_CONF_DIR/databases
[[ -z "$HAXBY_DATA" ]] && HAXBY_DATA=$HAXBY_CONF_DIR/pg
[[ ! -d "$HAXBY_DATA" ]] && mkdir $HAXBY_DATA

[[ -z "$PG_CONTRIB" ]] && PG_CONTRIB=$(pg_config --sharedir)/contrib
[[ -z "$PGDATA" ]] && PGDATA=$HAXBY_DATA/pgdata
[[ -z "$PGLOG" ]] && PGLOG=$HAXBY_DATA/pglog

export PG_CONTRIB
export PGDATA
export PGLOG

}

function haxby::core::modes {

HAXBY_MODE_DIR=$HAXBY_ROOT/modes
HAXBY_MODE_DIR=$(readlink -f "$HAXBY_MODE_DIR")

HAXBY_MODES="help"

. $HAXBY_MODE_DIR/init.sh
. $HAXBY_MODE_DIR/new-db.sh
. $HAXBY_MODE_DIR/start.sh
. $HAXBY_MODE_DIR/stop.sh
. $HAXBY_MODE_DIR/cleanup.sh

function haxby::modes::help {
    echo "HELP!"
    echo "Known modes: $HAXBY_MODES"
}

}
