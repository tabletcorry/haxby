#!/bin/echo "Do not run this directly"
# vim: ts=4:sts=4:sw=4:expandtab

function haxby::core::fail-in-production {
    if [[ -n "$HAXBY_IN_PRODUCTION" ]]; then
        echo "Not safe in production! Aborting."
        exit 1
    fi
}

function chomp {
    arg=$(cat -)
    newline=$(echo)
    echo -n "${arg%$newline}"
}

function haxby::core::get-schema-version {
    database=$1
    if [[ -n "$HAXBY_SCHEMA_VERSION_QUERY" ]]; then
        psql -A -t -d "$database" -c "$HAXBY_SCHEMA_VERSION_QUERY" | chomp
    else
        return 1
    fi
}

function haxby::core::find-schema-by-version {
    schema_dir=$1
    version=$2
    result=
    if [[ -z "$version" ]]; then
        result=$(find -L "$schema_dir" -name '*.sql' | tail -n 1 | chomp)
    else
        if [[ ! "$version" -ge 0 ]]; then
            echo "Invalid schema version" 1>&2
            return 1
        else
            result=$(find -L "$schema_dir" -name '*.sql' | \
                grep "/0*${version}_" | chomp)
        fi
    fi
    if [[ ! -f "$result" ]]; then
        echo "Invalid schema version" 1>&2
        return 1
    fi
    echo -n "$result"
}

function haxby::core::apply-schema-file {
    database=$1
    schema=$2
    psql="psql --echo-all --set=ON_ERROR_STOP="
    cecho "Loading $schema from schemas.d" $FG_BLUE
    $psql -f "$schema" -d "$database" >/dev/null
}

