#!/usr/bin/env bash
cat <<EOF
\connect postgres

DROP DATABASE IF EXISTS $1;
CREATE DATABASE $1;

\connect $1

-- Add any DB initialization code here
-- i.e. Create users/roles
EOF
