#!/usr/bin/env bash

set -e

cd `dirname $0`/..

db=$1
if [ -z "$db" ]; then
    echo "Usage: new-db.sh name"
    exit 1
fi

mkdir -p databases/$1/{schemas.d,data.d}
pushd databases/$1 >/dev/null
touch init.sql

(
cat <<EOF
\connect postgres

DROP DATABASE IF EXISTS $1;
CREATE DATABASE $1;

\connect $1

-- Add any DB initialization code here
-- i.e. Create users/roles
EOF
) >init.sql

popd >/dev/null
