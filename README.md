LabMapper
=========

![LabMapper screenshot](https://github.com/tjeezy/labmapper/raw/master/screenshot.png "LabMapper screenshot")

A baby project.

Installation
------------

    $ git clone https://tjeezy@github.com/tjeezy/labmapper.git
    $ rvm use 1.9.3@labmapper --create  # local ruby+gems container
    $ bundle install                    # grab dependencies
    $ ./labmapper.rb                    # creates socket.yaml
    $ ./web.rb                          # http://localhost:4567

Create CRON job to run csilwho every [n] minutes.

TODO
----

- make images same size and use background instead of img tag
