# Major portions of logic inspired by https://github.com/jayferd/balls
#  Primarily the rough idea for finding the lib directory
#  Also the method naming and mode function calling

set -e

mode=$1
shift || true

HAXBY_CORE="$HAXBY_ROOT/core"

. $HAXBY_CORE/readlink.sh
. $HAXBY_CORE/modes.sh
. $HAXBY_CORE/conf.sh
. $HAXBY_CORE/color.sh

haxby::core::readlink       # Needs to be first
haxby::core::load-conf
haxby::core::defaults
haxby::core::modes

for haxby_mode in $HAXBY_MODES
do
    if [[ "$haxby_mode" == "$mode" ]]
    then
        haxby::modes::$mode $@
        exit $?
    fi
done

echo "Unknown Mode"
haxby::modes::help
exit 1
