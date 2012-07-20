* Make python module to auto-discover haxby
* Add modes/flags to manage only the database within a running postgres
    * Would allow for multiple projects on shared instance without confusion
    * Would require using DROP DATABASE to ensure total wipe
* A useful `help` mode would be a major plus
    * List modes one per line, with a brief explanation
    * Per-mode detailed help
    * And perhaps a man page too!
    * Trigger help mode if `haxby` is run with no arguments
* Should be able to apply its configs to a real DB instance, for deployment
    * Then we are really cooking!
* More ways to do config autodiscovery
    * And a flag to specify the exact file
* Don't create pg folder unless necessary
* A mode to create the example config
* New Mode: Schema
    * Shows Numbered interface to allow editing of schema files
    * i.e: type '1', opens first schema file in $EDITOR
* Deal with ubuntu sillyness
    * ubuntu hides pg\_ctl behind wrapper
    * Either use the wrapper (ick) or discover/guess location of real binary
* Add mode to talk to Heroku db instances