# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register init-cluster
haxby::modes::help::register "init-cluster: create cluster"

function haxby::modes::init-cluster {
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
}
