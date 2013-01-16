#!/usr/bin/env coffee

###
Dependencies
###
program = require('commander')
log     = require('custom-logger').config { level: 0 }
fs      = require('fs')

###
Built-in types
--------------
There a three (3) general purpose, built-in statusses:
- info (green)
- warn (yellow)
- error (red)
###

# 1. General information output
log.info 'This might be a fun story that you could live without hearing...'

# 2. Warning to the user of a certain (soon to) occur(ing) risk
log.warn 'Dont compile your binaries as root user! Are you dumb?'

# Error or generic exception occured, too late now - you die
log.error 'Stop looking with the hands I told you! Now its broken...sigh'

###
Custom types
------------
Define a new, custom status message type with it's own name, color and debug
level it will respond to.
###
log.new

  # Cluster all specific debugging messages
  debug:
    level: 3            # verbosity level when to react and output
    flags: "debug"      # name of the event type which will occur
    color: "yellow"     # color highlight the type accordingly

  # Cluster all messages where we expect a user response/input
  prompt:
    level: 0            # we need an answer so always show
    flags: "prompt"     # perhaps change to 'question?' or 'input required?' or 'awaiting response'?
    color: "cyan"     # perhaps too danger-like? maybe tone it down a bit to cyan e.g.

  # Bundle all (really) informative help-context related info
  help:
    level: 0            # this is always useful
    flags: "attention"  # have focus pointed at me
    color: "blue"       # like the traffic signs

log.warn.flags = "☢ alert!"


log.debug "is this a bug?"
log.help "this is a very powerful feature, pay attention"
log.prompt "can you answer this?"
