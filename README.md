**Haxby** _n_: Any garden implement found in a potting shed whose exact 
purpose is unclear.

_Definition borrowed from "The Meaning of Liff" by Douglas Adams and 
John Lloyd_

# Purpose
Haxby is a quick and easy way to get a Postgresql database up and running. It
is primarily intended for developemental efforts.

# Usage
After you clone the repo, just run `new-db.sh <db-name>` and it will create
a directory with a `schemas.d` folder and `data.d` folder.

Once you drop some schema files into the folder above, you can run `init.sh` at
any time to stop and wipe any existing instance, then create a new one.

# Notes
You will need postgres. This is currently only tested on Homebrew Postgres 9.X
but it should work on prior versions and other platforms.

If you hit issues with shared memory (on mac), you are probably running more
than one instance of postgres. Don't do that. If you really need to though,
take a look at this document: http://jeffammons.net/2011/09/fixing-postgres-on-mac-10-7-tiger-for-django/

# Contributors
Some contributions were wiped out in the creation of the repo, they are listed
here

[adinardi](https://github.com/adinardi)
[danw](https://github.com/danw)
