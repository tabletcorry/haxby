#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register load
haxby::modes::help::register "load: Loads all of the schema files"

function haxby::modes::help::schema::load {
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


        cecho "Loading init.sql" $FG_BLUE
        PG_DATABASE=postgres
        psql --echo-all --set=ON_ERROR_STOP=1 -f init.sql >/dev/null
        dump_revision="-1"
        if [[ -e "dump.d" && -n "$HAXBY_FAST" ]]; then
            PG_DATABASE=postgres
            dumpfile=$(ls dump.d/ | sort -g | tail -1)
            cecho "Loading dump file $dumpfile" $FG_BLUE
            psql -f dump.d/$dumpfile
            dump_revision=$(echo $dumpfile | sed -E 's/^0*([0-9][0-9]*)[^0-9].*sql$/\1/')
            echo $revision
        fi

        for module in $PG_MODULES
        do
            cecho "Loading module $module" $FG_BLUE
            PG_DATABASE=$database
            psql -f $PG_CONTRIB/$module.sql
        done

        for schema in `find -L schemas.d -name '*.sql' | sort`
        do
            echo $schema $dump_revision
            revision=$(basename $schema | sed -E 's/^0*([0-9][0-9]*)[^0-9].*sql$/\1/')
            if [[ "$revision" -gt "$dump_revision" ]]; then
                haxby::core::apply-schema-file "$database" "$schema"
            else
                cecho "Skipping $schema due to newer dump" $FG_BLUE
            fi
        done

        if [[ -n "$RELOAD_DATA" ]]
        then
            cecho "Restoring data from backup" $FG_BLUE
            PG_DATABASE=$database
            psql --set=ON_ERROR_STOP -1 \
                -f $HAXBY_DATA/prior_data_$database -q >/dev/null
        else
            for testdata in `find -L data.d -name '*.sql'`
            do
                cecho "Loading $testdata from data.d" $FG_BLUE
                PG_DATABASE=$database
                psql -f $testdata >/dev/null
            done
        fi
        
        popd >/dev/null
    done
}
