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

function haxby::core::modes::register {
    if [ -n "$HAXBY_MODES" ]
    then
        HAXBY_MODES="$HAXBY_MODES $*"
    else
        HAXBY_MODES="$*"
    fi
}

function haxby::core::modes {

    HAXBY_MODE_DIR=$HAXBY_ROOT/modes
    HAXBY_MODE_DIR=$(readlink -f "$HAXBY_MODE_DIR")

    for mode_file in $HAXBY_MODE_DIR/*.sh
    do
        . $mode_file
    done
}
