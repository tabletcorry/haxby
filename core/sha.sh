function haxby::core::sha {
    if which sha256sum >/dev/null 2>&1
    then
        # Probably linux
        : # noop
    elif which shasum >/dev/null 2>&1
    then
        # Probably a mac
        function sha256sum {
            shasum -a 256 "$@"
        }
    else
        echo "No usable method to sha files found, exiting"
        exit 1
    fi
}
