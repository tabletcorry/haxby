# Major portions of logic inspired by https://github.com/jayferd/balls
#  Primarily the rough idea for finding the lib directory
#  Also the method naming and mode function calling

set -e

[[ -n "$HAXBY_DEBUG" ]] && set -x

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

. $HAXBY_CORE/readlink.sh
. $HAXBY_CORE/defaults.sh
. $HAXBY_CORE/modes.sh
. $HAXBY_CORE/conf.sh
. $HAXBY_CORE/color.sh
. $HAXBY_CORE/util.sh

haxby::core::readlink       # Needs to be first
haxby::core::load-conf
haxby::core::defaults
haxby::core::modes::use-root-mode-dir

haxby::core::modes::run "$mode" $@

