function haxby::core::search-conf-git {
    HAXBY_CONF=$(find $GIT_ROOT -name 'haxby.conf')
    CONF_COUNT=$(wc -l <<<$HAXBY_CONF)
    if [[ "$CONF_COUNT" -gt "1" ]]
    then
        echo "Found more than one 'haxby.conf', failed auto-conf"
        exit 1
    elif [[ "$CONF_COUNT" -eq "0" ]]
    then
        echo "No config was auto-discovered, exiting"
        exit 1
    fi
    echo $HAXBY_CONF
}

function haxby::core::search-conf {
    GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || true )
    [[ -n "$GIT_ROOT" ]] && HAXBY_CONF=$(haxby::core::search-conf-git)

    if [[ -z "$HAXBY_CONF" ]]; then
        echo "Haxby config auto-discovery for git failed"
    fi
}

function haxby::core::load-conf {
    if [[ -z "$HAXBY_CONF" ]]; then
        haxby::core::search-conf
    fi

    if [[ -z "$HAXBY_CONF" ]]
    then
        echo "No config provided or found, entering safemode"
        HAXBY_SAFEMODE=true
        return
    fi

    [[ ! -e "$HAXBY_CONF" ]] && { echo "Specified conf file does not exist"; exit 1; }

    HAXBY_CONF=$(readlink -f $HAXBY_CONF)
    HAXBY_CONF_DIR=$(dirname $HAXBY_CONF)
    . "$HAXBY_CONF"
}
