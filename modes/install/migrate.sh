#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register migrate
haxby::modes::help::register "migrate: Migrates the database to a newer schema version"

function haxby::modes::help::migrate {
    echo "usage: haxby migrate DATABASE [NEW_VERSION]"
    echo -e "\ndescription:"
    echo "Migrates a database to a newer schema version."
    echo "By default, migrates to the newest version."
}

function haxby::modes::schema::migrate {
    database=$1
    new_version=$2

    # Find the schemas directory
    if [[ -z "$database" ]]; then
        echo "Database name not specified"
        haxby::modes::schema::help
        return 1
    elif [[ ! -d "$HAXBY_DATABASE_D/$database" ]]; then
        echo "Invalid database name"
        return 1
    else
        pushd "$HAXBY_DATABASE_D/$database" >/dev/null
        if [[ ! -d schemas.d ]]; then
            echo "Missing schemas.d"
            return 1
        fi
    fi

    # Find the newest schema file to use
    last_file=$(haxby::core::find-schema-by-version schemas.d "$new_version")

    # Get the current version number
    cur_version=$(haxby::core::get-schema-version "$database")

    # Check whether the current file is also the latest
    cur_file=$(haxby::core::find-schema-by-version schemas.d "$cur_version")
    if [ "$cur_file" = "$last_file" ]; then
        popd >/dev/null
        cecho "The database is already up-to-date." $FG_BLUE
        return 0
    fi

    # Get the next file after the current file
    first_file=$(haxby::core::find-schema-by-version schemas.d $(( cur_version + 1 )))

    # Apply all files in order from first to last
    active=
    for file in $(find -L schemas.d -name '*.sql'); do
        [[ "$file" = "$first_file" ]] && active=true
        # [[ -n "$active" ]] && $(haxby::core::apply-schema-file) "$database" "$file"
        [[ -n "$active" ]] && echo apply $database $file
        [[ "$file" = "$last_file" ]] && break
    done

    popd >/dev/null
    cecho "The database is now up-to-date." $FG_BLUE
}

