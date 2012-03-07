#!/usr/bin/env bash

set -e

PREFIX="/"

function haxby::install::uninstall {
    rm $PREFIX/bin/haxby
    rm -r $PREFIX/share/haxby
}

function haxby::install::install {
    mkdir -p $PREFIX/bin
    
    mkdir -p $PREFIX/share/haxby/{core,modes}
    cp ./modes/* $PREFIX/share/haxby/modes/
    cp ./core/* $PREFIX/share/haxby/core/
    cp ./haxby.conf.example $PREFIX/share/haxby/
    cp ./LICENSE $PREFIX/share/haxby/

    echo "#!/usr/bin/env bash" >$PREFIX/bin/haxby
    echo "HAXBY_ROOT=$PREFIX/share/haxby" >>$PREFIX/bin/haxby
    echo '. $HAXBY_ROOT/core/haxby.sh' >>$PREFIX/bin/haxby
    chmod +x $PREFIX/bin/haxby
}

while getopts 'p:u' opt; do
    case $opt in
        p)
            PREFIX=$OPTARG
        ;;
        u)
            haxby::install::uninstall
            exit $?
    esac
done

haxby::install::install
