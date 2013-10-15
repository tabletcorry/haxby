function haxby::core::sha {
    if which sha1sum >/dev/null 2>&1
    then
        # Probably linux
        : # noop
    elif which shasum >/dev/null 2>&1
    then
        # Probably a mac
        function sha1sum {
            shasum $@
        }
    else
        echo "No usable method to sha files found, exiting"
        exit 1
    fi
}
