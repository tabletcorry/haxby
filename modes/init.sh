# vim: ts=4:sts=4:sw=4:expandtab

haxby::core::modes::register init
haxby::modes::help::register "init: create cluster and load schema"

function haxby::modes::init {
    haxby::modes::init-cluster $@
    haxby::modes::schema load $@
}
