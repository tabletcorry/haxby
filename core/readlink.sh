function haxby::core::readlink {
    # BSD readlink does not work with the args used in haxby
    if readlink -f $HOME >/dev/null 2>&1
    then
        # System has gnu coreutils (probably)
        : # noop
    elif which greadlink >/dev/null 2>&1
    then
        # System as gnu coreutils installed, but to alternate names
        function readlink {
            greadlink $@
        }
    elif python -c 'import os,sys;print os.path.realpath(sys.argv[1])' / >/dev/null 2>&1
    then
        # System has no coreutils, use python
        function readlink {
            shift # Python does not need the -f option
            python -c 'import os,sys;print os.path.realpath(sys.argv[1])' $@
        }
    else
        echo "No usable method to discover canonical path found, exiting"
        exit 1
    fi
}
