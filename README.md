Redis Web
=========
What does it do?
----------------
Redis web is a small sinatra app that provides a way to inspect a [redis](http://redis.io/) database using a browser.

Redis does not come with any front end for viewing data.
This presents a problem when trying to inspect an application's data within redis.
Keys, values, and types can be retrieved via curl, but this gets tiresome quickly.

Redis web provides a quick way to inspect this data in real time.


Features
--------
Redis web displays the following data:

* Keys
* Values
* Types
* Time-to-live

Redis web also provides:

* Searching
* Deleting
* Polling for real time updates.


How do I use it?
----------------
Clone the project

    git clone https://github.com/agrieser/redis_web.git
    cd redis_web

Install dependencies:

    bundle

Run:

    thin start

If you need to edit redis connection settings, check out `config/redis.yml`

    host: localhost
    port: 6379
