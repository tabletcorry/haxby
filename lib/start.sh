#!/bin/bash

cd `dirname $0`/..

export PG_CONTRIB=$(pg_config --sharedir)/contrib

export PGDATA=pgdata
export PGLOG=pglog

pg_ctl -l $PGLOG -w start
