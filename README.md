**Haxby** _n_: Any garden implement found in a potting shed whose exact 
purpose is unclear.

_Definition borrowed from "The Meaning of Liff" by Douglas Adams and 
John Lloyd_

# WARNING
Please note that this project is still under development. It may be a bit
difficult to figure out or use. I will be making it more usable as time allows.

Currently, all modes except schema have been used fairly extensively, so they 
could be considered "safe". The schema mode is still very new and not tested.

Feel free to message me to ask how it works.

# Purpose
Haxby is a quick and easy way to get a Postgresql database up and running. It
is primarily intended for developemental efforts.

# Usage
`haxby help` has been implemented, so it should be considered a main resource
for trying to use haxby.

Commands in haxby are executed using modes, ala `haxby init` or `haxby stop`.

A general workflow for haxby is to create a database with `haxby newdb name`
then initialize and start the database with `haxby init`

Adding a config file may be a good idea too! So long as you are in a git
repository (and why wouldn't you be) you can put a file named `haxby.conf`
anywhere (in the repo, that is) and haxby will find it. An example config is
available in the source tree.

# Notes
You will need postgres. This is currently only tested on Homebrew Postgres 9.X
but it should work on prior versions and other platforms.

If you hit issues with shared memory (on mac), you are probably running more
than one instance of postgres. Don't do that. If you really need to though,
take a look at this document: http://jeffammons.net/2011/09/fixing-postgres-on-mac-10-7-tiger-for-django/

# Initial Contributors
Some contributions were wiped out in the creation of the repo, they are listed
here


* [adinardi](https://github.com/adinardi)
* [danw](https://github.com/danw)
