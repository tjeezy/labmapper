Labmapper
=========

![Labmapper screenshot](https://github.com/tjeezy/labmapper/raw/master/screenshot.png "Labmapper screenshot")

A baby project.

Installation
------------

    $ git clone https://tjeezy@github.com/tjeezy/labmapper.git
    $ rvm use 1.9.3@labmapper --create  # local ruby+gems container
    $ bundle install                    # grab dependencies

Configuration
-------------

- Create a <labname>.labrc file in the root of the project.

### Basic idea

- empty lines are ignored
- lines starting with `=` (`/^= (.\*)$/`) set the title
- lines starting with `;` (~ `/^;(.\*)\|?(\..*)*$`) set then 'token' layout
- lines starting with a 'token' or 'token' range define the token

### Setting a title

    = <title>

### Laying out tokens

    ;<token><token>...[|[.<class>[.<class>[...]]]]
    ;...

### Defining a token

    <token>|[direction]#<id>[.<class>[.<class>[...]]]
    <token-range>|[direction]#<id>[.<class>[.<class>[...]]]

Token restrictions:

- must be a single character
- in this alphabet: `abcdefghijklmnopqrstuvwxyz` (upper case too) and `0123456789`

Special tokens:

- `*` -- definition is applied to all other tokens

### Example file

    = Example Lab
    ;01|.row
    *|^.machine
    0|#first
    1|#second.spare

A two-computer lab -- romantic.


Usage
-----

    $ ./script/poller                      # initial poll (creates socket.json)
    $ ./script/web                         # http://localhost:4567

Then create a CRON job to run ./bin/poller every [n] minutes.

TODO
----

- make images same size and use background instead of img tag
