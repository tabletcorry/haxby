#!/bin/bash

haxby::core::modes::register socket
haxby::modes::help::register "socket: provide a socket address for contacting postgres"

function haxby::modes::help::socket {
    echo "usage: haxby socket"
    echo -e "\ndescription:"
    echo "provide a connection string to contact postgres"
}

function haxby::modes::socket {
    socket=$PG_SOCKET_DIR/
    echo $socket
}
