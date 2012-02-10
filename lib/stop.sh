#!/bin/bash

HAXBY_MODES="$HAXBY_MODES stop"

function haxby::stop {

pg_ctl stop -m immediate

}
