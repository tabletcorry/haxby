#!/usr/bin/env bash

haxby::core::modes::register newdb
haxby::modes::help::register "newdb: Create new database schema folder"

function haxby::modes::newdb {
    db=$1
    if [[ -z "$db" ]]
    then
        echo "Usage: haxby newdb name"
        exit 1
    fi

    mkdir -p $HAXBY_DATABASE_D/$1/{schemas.d,data.d}
    pushd $HAXBY_DATABASE_D/$1 >/dev/null
    touch init.sql

    {
        . $HAXBY_MODE_DIR/templates/new-db.init.sql
    } >init.sql

    popd >/dev/null
}
