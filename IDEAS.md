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
* <strike>Make the lib directory a build-time configuration option</strike>
* More ways to do config autodiscovery
    * And a flag to specify the exact file
* Don't create pg folder unless necessary
* A mode to create the example config
* An option to save the old data on init
* Init using data from existing instance
