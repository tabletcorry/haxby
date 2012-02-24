#!/bin/bash

HAXBY_MODES="$HAXBY_MODES init"

function haxby::lib::init {

cd $HAXBY_DATA

set +e
pg_ctl stop -m immediate
rm -r $PGDATA
set -e

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

initdb >>$PGLOG 2>&1

[[ -e "postgresql.conf" ]] && cp postgresql.conf $PGDATA

pg_ctl -l $PGLOG -w start

for database in `ls $HAXBY_DATABASE_D`
do
    pushd $HAXBY_DATABASE_D/$database
    #psql -d $database -f $PG_CONTRIB/uuid-ossp.sql
    psql="psql --echo-all --set=ON_ERROR_STOP="
    $psql -f init.sql -d postgres

    for schema in `find schemas.d -name '*.sql'`
    do
      $psql -f $schema -d $database
    done

    for testdata in `find data.d -name '*.sql'`
    do
      $psql -f $testdata -d $database
    done
    popd
done
}
