#!/bin/bash
# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register install
haxby::modes::help::register "install: Install what you need"

function haxby::modes::help::install {
    haxby::core::modes::run-with-submodes install help $@
}

function haxby::modes::install {
    SCRATCH_DIR="$INSTALL_DIR/scratch"
    PROFILE_DIR="$INSTALL_PROFILE_DIR"

    [[ -e $INSTALL_DIR ]] || mkdir $INSTALL_DIR
    [[ -e $SCRATCH_DIR ]] || mkdir $SCRATCH_DIR
    [[ -e $PROFILE_DIR ]] || mkdir $PROFILE_DIR

    if [[ -e /proc/cpuinfo ]]; then
        CORES=$(grep -c processor /proc/cpuinfo)
    elif sysctl -n hw.ncpu >/dev/null; then
        CORES=$(sysctl -n hw.ncpu)
    else
        echo "Core count discovery failed, not on mac or linux?"
        CORES=1
    fi

    haxby::core::modes::run-with-submodes install $@
}

