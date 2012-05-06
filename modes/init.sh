# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register init
haxby::modes::help::register "init: create cluster and load schema"

function haxby::modes::init {
    if [[ -n $(ls "$HAXBY_DATABASE_D") ]]; then
      haxby::core::fail-in-production
    fi

    case $1 in
        "reload" | "restore")
            RELOAD_DATA=true
            ;;
    esac

    cd $HAXBY_DATA

    if [[ -n "$RELOAD_DATA" ]]
    then
        for database in `ls $HAXBY_DATABASE_D`
        do
            cecho "Backing up data" $FG_BLUE
            pg_dump -a -F plain -O --column-inserts \
                -f $HAXBY_DATA/prior_data_$database $database \
                || { echo "Backup failed. Is the DB online?"; exit 1; }
        done
    fi
    cecho "Stopping old database" $FG_BLUE
    pg_ctl stop -m immediate || true

    cecho "Deleting old database files" $FG_BLUE
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

    cecho "Creating new database files" $FG_BLUE
    initdb >>$PGLOG 2>&1

    [[ -e "postgresql.conf" ]] && cp postgresql.conf $PGDATA
    [[ -e "pg_hba.conf" ]] && cp pg_hba.conf $PGDATA
    [[ -e "pg_ident.conf" ]] && cp pg_ident.conf $PGDATA

    {
        . $HAXBY_MODE_DIR/templates/init.postgresql.conf
    } >>$PGDATA/postgresql.conf

    {
        . $HAXBY_MODE_DIR/templates/init.postgresql.haxby.conf
    } >$HAXBY_DATA/postgresql.haxby.conf


    cecho "Starting new database" $FG_BLUE
    pg_ctl -l $PGLOG -w start

    for database in `ls $HAXBY_DATABASE_D`
    do
        pushd $HAXBY_DATABASE_D/$database >/dev/null
        psql="psql --echo-all --set=ON_ERROR_STOP="
        cecho "Loading init.sql" $FG_BLUE
        $psql -f init.sql -d postgres >/dev/null

        for module in $PG_MODULES
        do
            cecho "Loading module $module" $FG_BLUE
            psql -d $database -f $PG_CONTRIB/$module.sql
        done

        for schema in `find -L schemas.d -name '*.sql'`
        do
            haxby::core::apply-schema-file "$database" "$schema"
        done

        if [[ -n "$RELOAD_DATA" ]]
        then
            cecho "Restoring data from backup" $FG_BLUE
            psql --set=ON_ERROR_STOP -1 -d $database \
                -f $HAXBY_DATA/prior_data_$database -q >/dev/null
        else
            for testdata in `find -L data.d -name '*.sql'`
            do
                cecho "Loading $testdata from data.d" $FG_BLUE
                $psql -f $testdata -d $database >/dev/null
            done
        fi
        
        popd >/dev/null
    done
}
