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

function haxby::core::load-conf {
    GIT_ROOT=$(git rev-parse --show-toplevel || true)
    [[ -n "$GIT_ROOT" ]] && HAXBY_CONF=$(haxby::core::search-conf-git)

    [[ -z "$HAXBY_CONF" ]] && { echo "Config auto-discovery failed, exiting"; exit 1; }

    HAXBY_CONF=$(readlink -f $HAXBY_CONF)
    HAXBY_CONF_DIR=$(dirname $HAXBY_CONF)
    . "$HAXBY_CONF"
}
