#!/bin/bash

HAXBY_MODES="$HAXBY_MODES init"

function haxby::modes::init {

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
[[ -e "pg_hba.conf" ]] && cp pg_hba.conf $PGDATA
[[ -e "pg_ident.conf" ]] && cp pf_ident.conf $PGDATA

pg_ctl -l $PGLOG -w start

for database in `ls $HAXBY_DATABASE_D`
do
    pushd $HAXBY_DATABASE_D/$database
    psql="psql --echo-all --set=ON_ERROR_STOP="
    $psql -f init.sql -d postgres

    for module in $PG_MODULES
    do

        psql -d $database -f $PG_CONTRIB/$module.sql
    done

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
