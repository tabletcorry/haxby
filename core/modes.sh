#!/bin/echo "Do not run this directly"
# vim: ts=4:sts=4:sw=4:expandtab

function haxby::core::defaults {
    [[ -z "$HAXBY_TMP" ]] && HAXBY_TMP=/tmp/haxby
    [[ ! -d "$HAXBY_TMP" ]] && mkdir $HAXBY_TMP

    [[ -z "$HAXBY_DATABASE_D" ]] && HAXBY_DATABASE_D=$HAXBY_CONF_DIR/databases
    [[ -z "$HAXBY_DATA" ]] && HAXBY_DATA=$HAXBY_CONF_DIR/pg
    [[ ! -d "$HAXBY_DATA" ]] && mkdir $HAXBY_DATA

    [[ -z "$PG_CONTRIB" ]] && PG_CONTRIB=$(pg_config --sharedir)/contrib
    [[ -z "$PGDATA" ]] && PGDATA=$HAXBY_DATA/pgdata
    [[ -z "$PGLOG" ]] && PGLOG=$HAXBY_DATA/pglog

    [[ -z "$PG_LISTEN" ]] && PG_LISTEN="''"
    [[ -z "$PG_PORT" ]] && PG_PORT=5432
    [[ -z "$PG_SOCKET_DIR" ]] && PG_SOCKET_DIR=$HAXBY_DATA
    [[ -z "$PG_DEFAULT_DATABASE" ]] && PG_DEFAULT_DATABASE=

    # Set options for psql to use
    export PGDATABASE=$PG_DEFAULT_DATABASE
    export PGHOST=$PG_SOCKET_DIR
    export PGPORT=$PG_PORT

    # Export options for initdb/pg_ctl to use
    export PG_CONTRIB
    export PGDATA
    export PGLOG
}

function haxby::core::modes::register {
    if [[ -n "$HAXBY_MODES" ]]
    then
        HAXBY_MODES="$HAXBY_MODES $*"
    else
        HAXBY_MODES="$*"
    fi
}

# Load the modes in the current mode directory
function haxby::core::modes::load-modes {
    for mode_file in $HAXBY_MODE_DIR/*.sh
    do
        . $mode_file
    done
}

# Use the root mode directory
function haxby::core::modes::use-root-mode-dir {
    HAXBY_MODE_DIR=$HAXBY_ROOT/modes
    HAXBY_MODE_DIR=$(readlink -f "$HAXBY_MODE_DIR")
    HAXBY_MODES=

    haxby::core::modes::load-modes
}

# Use a directory of submodes
# 1. The directory's name, relative to the current mode directory
function haxby::core::modes::use-mode-dir {
    mode_name=$1
    HAXBY_MODE_DIR=$HAXBY_MODE_DIR/$mode_name
    HAXBY_MODE_DIR=$(readlink -f "$HAXBY_MODE_DIR")
    HAXBY_MODES=

    haxby::core::modes::load-modes
}

# Run a mode
function haxby::core::modes::run {
    namespace=$1
    mode=$2
    shift 2 || true
    for haxby_mode in $HAXBY_MODES
    do
        if [[ "$haxby_mode" == "$mode" ]]
        then
            $namespace::$mode $@
            exit $?
        fi
    done

    echo "Unknown Mode"
    haxby::modes::help
    exit 1
}

