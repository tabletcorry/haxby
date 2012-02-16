* Add modes/flags to manage only the database within a running postgres
    * Would allow for multiple projects on shared instance without confusion
    * Would require using DROP DATABASE to ensure total wipe
* A useful `help` mode would be a major plus
    * And perhaps a man page too!
* Should be able to apply its configs to a real DB instance, for deployment
    * Then we are really cooking!
* Support older versions of postgres
    * Specifically, pgctl only recently added initdb as a mode
