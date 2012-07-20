#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register load
haxby::modes::help::register "load: Loads all of the schema files"

function haxby::modes::help::migrate {
    #TODO
    echo "Docs not written yet"
}

function haxby::modes::schema::load {
    if [[ -n $(ls "$HAXBY_DATABASE_D") ]]; then
      haxby::core::fail-in-production
    fi

    case $1 in
        "reload" | "restore")
            RELOAD_DATA=true
            ;;
    esac

    cd $HAXBY_DATA

    for database in `ls $HAXBY_DATABASE_D`
    do
        pushd $HAXBY_DATABASE_D/$database >/dev/null
        psql="psql --echo-all --set=ON_ERROR_STOP="
        cecho "Loading init.sql" $FG_BLUE
        $psql -f init.sql -d postgres >/dev/null

        for module in $PG_MODULES
        do
            cecho "Loading module $module" $FG_BLUE
            psql -d $database -f $PG_CONTRIB/$module.sql
        done

        for schema in `find -L schemas.d -name '*.sql' | sort`
        do
            haxby::core::apply-schema-file "$database" "$schema"
        done

        if [[ -n "$RELOAD_DATA" ]]
        then
            cecho "Restoring data from backup" $FG_BLUE
            psql --set=ON_ERROR_STOP -1 -d $database \
                -f $HAXBY_DATA/prior_data_$database -q >/dev/null
        else
            for testdata in `find -L data.d -name '*.sql'`
            do
                cecho "Loading $testdata from data.d" $FG_BLUE
                $psql -f $testdata -d $database >/dev/null
            done
        fi
        
        popd >/dev/null
    done
}
