#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register postgres
haxby::modes::help::register "postgres: Install it"

function haxby::modes::help::install::postgres {
    #TODO
    echo "Docs not written yet"
}

function haxby::modes::install::postgres {
    cd $SCRATCH_DIR

    PG_VERSION="9.3.0"
    PG_ARCHIVE="postgresql-${PG_VERSION}.tar.bz2"
    PG_URL="http://ftp.postgresql.org/pub/source/v$PG_VERSION/$PG_ARCHIVE"
    PG_SHA="63a7b8788cd18247d7af5fd4a320abebb0535a44  $PG_ARCHIVE"
    
    if [[ -n "$PIP_DOWNLOAD_CACHE" ]]; then
        [[ -e "$PIP_DOWNLOAD_CACHE/$PG_ARCHIVE" ]] && ln "$PIP_DOWNLOAD_CACHE/$PG_ARCHIVE"
    fi

    [[ ! -e $PG_ARCHIVE ]] && curl -f -o $PG_ARCHIVE $PG_URL


    sha1sum -c <(echo $PG_SHA) || { rm $PG_ARCHIVE; echo "Checksum Failed"; exit 1; }

    if [[ -n "$PIP_DOWNLOAD_CACHE" ]]; then
        ln $PG_ARCHIVE "$PIP_DOWNLOAD_CACHE/$PG_ARCHIVE"
    fi

    # TODO: Perhaps skip if target exists?
    tar xjf $PG_ARCHIVE

    cd postgresql-$PG_VERSION

    # TODO BUG: Detect existence of readline, zlib

    # TODO: Figure out what options we may want
    ./configure --prefix=$INSTALL_DIR/postgres
    make -s -j$CORES
    make -s install
    make -s distclean

    echo "export PATH=$INSTALL_DIR/postgres/bin:\$PATH" >$PROFILE_DIR/postgres.sh

}
