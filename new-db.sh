#!/usr/bin/env bash

set -e

db=$1

mkdir -p databases/$1/{schemas.d,data.d}
pushd databases/$1
touch init.sql

popd
