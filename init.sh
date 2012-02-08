#!/bin/bash

cd `dirname $0`

export PG_CONTRIB=$(pg_config --sharedir)/contrib

export PGDATA=pgdata
export PGLOG=pglog

pg_ctl stop -m immediate
rm -r $PGDATA

echo "***" >>$PGLOG
echo "*** Postgres init.sh restart at $(date)" >>$PGLOG
echo "*** $(git log -1 --oneline)" >>$PGLOG
echo "***"  >>$PGLOG

pg_ctl -l $PGLOG initdb

pg_ctl -l $PGLOG -w start

for database in `ls databases`
do
    pushd databases/$database
    #psql -d $database -f $PG_CONTRIB/uuid-ossp.sql
    psql --echo-all -f init.sql postgres

    for schema in `find schemas.d -name '*.sql'`
    do
      psql --echo-all -f $schema $database
      psql --echo-all -f $schema ${database}_test
    done

    for testdata in `find data.d -name '*.sql'`
    do
      psql --echo-all -f $testdata $database
      psql --echo-all -f $testdata ${database}_test
    done
    popd
done
