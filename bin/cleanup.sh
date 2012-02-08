#!/bin/bash

cd `dirname $0`/..

export PGDATA=pgdata
export PGLOG=pglog

pg_ctl stop -m immediate

rm -r pgdata pglog
