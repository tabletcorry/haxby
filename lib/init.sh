#!/bin/bash

HAXBY_MODES="$HAXBY_MODES init"

function haxby::init {

cd $HAXBY_DATA

pg_ctl stop -m immediate
rm -r $PGDATA

echo "***" >>$PGLOG
echo "*** Postgres init.sh restart at $(date)" >>$PGLOG
echo "*** $(git log -1 --oneline)" >>$PGLOG
echo "***"  >>$PGLOG

pg_ctl -l $PGLOG initdb

pg_ctl -l $PGLOG -w start

for database in `ls $HAXBY_DATABASE_D`
do
    pushd $HAXBY_DATABASE_D/$database
    #psql -d $database -f $PG_CONTRIB/uuid-ossp.sql
    psql --echo-all -f init.sql postgres

    for schema in `find schemas.d -name '*.sql'`
    do
      psql --echo-all -f $schema $database
    done

    for testdata in `find data.d -name '*.sql'`
    do
      psql --echo-all -f $testdata $database
    done
    popd
done
}
