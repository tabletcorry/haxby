#!/bin/bash

haxby::core::modes::register init
haxby::modes::help::register "init: create cluster and load schema"

function haxby::modes::init {
    case $1 in
        "reload")
            RELOAD_DATA=true
            ;;
        "restore")
            RELOAD_DATA=true
            ;;
    esac

    cd $HAXBY_DATA

    if [ -n "$RELOAD_DATA" ]; then
        for database in `ls $HAXBY_DATABASE_D`
        do
            cecho "Backing up data" $blue
            pg_dump -a -F plain -O --column-inserts \
                -f $HAXBY_DATA/prior_data_$database $database \
                || { echo "Backup failed. Is the DB online?"; exit 1; }
        done
    fi
    cecho "Stopping old database" $blue
    set +e
    pg_ctl stop -m immediate
    set -e
    cecho "Deleting old database files" $blue
    rm -rf $PGDATA

    if pgrep postgres
    then
        echo "A Postgres process is still running"
        echo "This will mess things up (usually); Bailing"
        exit 1
    fi

    echo "***" >>$PGLOG
    echo "*** Postgres init.sh restart at $(date)" >>$PGLOG
    echo "*** $(git log -1 --oneline)" >>$PGLOG
    echo "***"  >>$PGLOG

    cecho "Creating new database files" $blue
    initdb >>$PGLOG 2>&1

    [[ -e "postgresql.conf" ]] && cp postgresql.conf $PGDATA
    [[ -e "pg_hba.conf" ]] && cp pg_hba.conf $PGDATA
    [[ -e "pg_ident.conf" ]] && cp pf_ident.conf $PGDATA

    cecho "Starting new database" $blue
    pg_ctl -l $PGLOG -w start

    for database in `ls $HAXBY_DATABASE_D`
    do
        pushd $HAXBY_DATABASE_D/$database >/dev/null
        psql="psql --echo-all --set=ON_ERROR_STOP="
        cecho "Loading init.sql" $blue
        $psql -f init.sql -d postgres >/dev/null

        for module in $PG_MODULES
        do
            cecho "Loading module $module" $blue
            psql -d $database -f $PG_CONTRIB/$module.sql
        done

        for schema in `find -L schemas.d -name '*.sql'`
        do
            cecho "Loading $schema from schemas.d" $blue
            $psql -f $schema -d $database >/dev/null
        done


        if [ -n "$RELOAD_DATA" ]; then
            cecho "Restoring data from backup" $blue
            psql --set=ON_ERROR_STOP -1 -d $database -f $HAXBY_DATA/prior_data_$database -q >/dev/null
        else
            for testdata in `find -L data.d -name '*.sql'`
            do
                cecho "Loading $testdata from data.d" $blue
                $psql -f $testdata -d $database >/dev/null
            done
        fi
        
        popd >/dev/null
    done
}
