# Major portions of logic inspired by https://github.com/jayferd/balls
#  Primarily the rough idea for finding the lib directory
#  Also the method naming and mode function calling

set -e

[[ -n "$HAXBY_DEBUG" ]] && set -x

if [[ $EUID -eq 0 && -z "$HAXBY_ROOT_SMASH" ]]; then
    echo "Haxby should not be run as root/sudo" 1>&2
    echo "If you really know what you are doing, set HAXBY_ROOT_SMASH" 1>&2
    exit 1
fi

while getopts ":f:" opt; do
    case $opt in
        f)
            HAXBY_CONF="$OPTARG"
            shift; shift
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

mode=$1
shift || true

HAXBY_CORE="$HAXBY_ROOT/core"
HAXBY_MODE_NAMESPACE="haxby::modes"

exec 8>&1
exec 9>&2

function command_not_found_handle {
    cmd=$1
    shift

    if which $cmd
    then
        set +e
        $cmd $*
        return_code=$?
        set -e
    else
        return_code=127
    fi

    if [ "$return_code" -eq 127 ]; then
        echo "Command not found: $cmd" >&9
    fi

    return $return_code
}

. $HAXBY_CORE/readlink.sh
. $HAXBY_CORE/sha.sh
. $HAXBY_CORE/defaults.sh
. $HAXBY_CORE/modes.sh
. $HAXBY_CORE/conf.sh
. $HAXBY_CORE/color.sh
. $HAXBY_CORE/util.sh


haxby::core::readlink       # Needs to be first
haxby::core::sha            # Early is good
haxby::core::load-conf
haxby::core::defaults
haxby::core::modes::use-root-mode-dir

haxby::core::modes::run "$mode" $@

