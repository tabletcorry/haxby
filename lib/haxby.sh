#!/bin/echo "Do not run this directly"

[[ -z "$HAXBY_TMP" ]] && HAXBY_TEMP=/tmp/haxby
[[ ! -d "$HAXBY_TMP" ]] && mkdir $HAXBY_TMP

. $HAXBY_LIB/init.sh
. $HAXBY_LIB/new-db.sh
. $HAXBY_LIB/start.sh
. $HAXBY_LIB/stop.sh
. $HAXBY_LIB/cleanup.sh
