#!/bin/echo "Do not run this directly"
# vim: ts=4:sts=4:sw=4:expandtab

function haxby::core::defaults {
    [[ -z "$HAXBY_TMP" ]] && HAXBY_TMP=/tmp/haxby

    [[ -z "$HAXBY_DATABASE_D" ]] && HAXBY_DATABASE_D=$HAXBY_CONF_DIR/databases
    [[ -z "$HAXBY_DATA" ]] && HAXBY_DATA=$HAXBY_CONF_DIR/pg

    if [[ -z "$HAXBY_SAFEMODE" ]]
    then
        [[ ! -d "$HAXBY_TMP" ]] && mkdir $HAXBY_TMP
        [[ ! -d "$HAXBY_DATA" ]] && mkdir $HAXBY_DATA
    fi

    [[ -z "$HAXBY_SLOW" ]] && HAXBY_FAST=true

    INSTALL_DIR="$HAXBY_DATA/install"
    INSTALL_PROFILE_DIR="$INSTALL_DIR/profile.d"
    if [[ -e "$INSTALL_PROFILE_DIR" ]]; then
        files=$(ls $INSTALL_PROFILE_DIR)
        for profile in $files
        do
            source $INSTALL_PROFILE_DIR/$profile
        done
    fi

    if [[ -z "$HAXBY_SCHEMA_VERSION_QUERY" ]]; then
      HAXBY_SCHEMA_VERSION_QUERY="SELECT MAX(version) FROM app.schema_version;"
    fi

    if which pg_config >/dev/null 2>&1
    then
        [[ -z "$PG_CONTRIB" ]] && PG_CONTRIB=$(pg_config --sharedir)/contrib
    fi
    [[ -z "$PGDATA" ]] && PGDATA=$HAXBY_DATA/pgdata
    [[ -z "$PGLOG" ]] && PGLOG=$HAXBY_DATA/pglog

    [[ -z "$PG_LISTEN" ]] && PG_LISTEN="''"
    [[ -z "$PG_PORT" ]] && PG_PORT=5432
    [[ -z "$PG_SOCKET_DIR" ]] && PG_SOCKET_DIR=$HAXBY_DATA
    [[ -z "$PG_DEFAULT_DATABASE" ]] && PG_DEFAULT_DATABASE=
    [[ -z "$PG_USER" ]] && PG_USER=$USER
    [[ -z "$PG_PASSWORD" ]] && PG_PASSWORD=""

    # Set options for psql to use
    PGDATABASE=$PG_DEFAULT_DATABASE
    PGHOST=$PG_SOCKET_DIR
    PGPORT=$PG_PORT
    PGPASSWORD=$PG_PASSWORD
    PGUSER=$PG_USER

    export PSQL_CONN_STRING="host=$PGHOST port=$PGPORT user=$PGUSER"
    if [[ -n "$PGPASSWORD" ]]; then
        export PSQL_CONN_STRING="$PSQL_CONN_STRING password=$PGPASSWORD"
    fi

    # Export options for initdb/pg_ctl to use
    export PG_CONTRIB
    export PGDATA
    export PGLOG
}

