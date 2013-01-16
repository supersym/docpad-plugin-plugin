#!/usr/bin/env coffee

log = require('custom-logger').config { level: 0 }

log.info 'hello world!'

log.warn 'carefule there, world!'

log.error 'WHOA WHOA WHOA world?!'


log.new
  debugger:
    level: 1
    event: "debug"
    color: "yellow"

log.debugger( "is this a bug?" ); //outputs "debug:  is this a bug?"
