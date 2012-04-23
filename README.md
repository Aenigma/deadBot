# deadBot IRC Client

Program is in very early stages.

## Usage

`config.yaml` will be created upon the first run. Configure it as needed.

Invocation should be from the project directory as so:

    ./bin/deadbot

Default behavior is to log to `irc.log`. This cannot be changed as of now. Send C-d to send quit and parts to servers. Whilst the configuration file supports multiple servers, this probably won't work very well in practice.

## TODO

* Make a class which accepts hash options.
**DONE**
* Class should include methods to separate out types of content from the server
 (e.g., content from channel, content from private messages, content from
server, etc.)
**IN PROGRESS**
* The above class should probably have some way to automatically parse certain
things separately to do certain things like respond to pings.
**Done**
* Some sort of dictionary syntax for configurations so source doesn't need to be modified
**NOT STARTED**
