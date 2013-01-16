
#global require

log_event = (options) ->
  @flags = options.flags
  @level = options.level or 0
  @color = options.color or "green"

dateFormat = require("dateformat")
colors = require("colors")
events = {}

options =
  level: 0
  format: "%timestamp% - %flags%:%padding%  %message%"
  timestamp: "HH:MM:ss"

log_event::config = (config) ->
  for key of config
    this[key] = config[key]  if config.hasOwnProperty(key)
  this

log_event::__defineGetter__ "padding", ->
  length = 0
  padding = ""
  for key of events
    length = (if length < events[key].flags.length then events[key].flags.length else length)  if events.hasOwnProperty(key)
  i = 0

  while i < length - @event.length
    padding += " "
    i++
  padding

log_event::output = (input) ->
  if options.level <= @level
    message = ""
    for i of input
      message += " " + ((if typeof input[i] is "object" then JSON.stringify(input[i], null) else input[i]))  if input.hasOwnProperty(i)
    format = @format or options.format
    #timestamp
    #log event & color
    output = format.replace("%timestamp%", dateFormat(new Date(), @timestamp or options.timestamp)).replace("%flags%", @flags[@color]).replace("%padding%", @padding).replace("%message%", message)
    console.log output

exports.config = (config) ->
  for key of config
    options[key] = config[key]  if options.hasOwnProperty(key)
  this

nFn = (e) ->
  ->
    if arguments_.length is 0
      events[e]
    else
      events[e].output arguments_

exports.custom = (newEvents) ->
  for flags of newEvents
    events[flags] = new log_event(newEvents[flags])  if newEvents.hasOwnProperty(flags)
    this[flags] = nFn(flags)
  this

exports.custom
  info:
    color: "green"
    level: 0
    flags: "info"

  warn:
    color: "yellow"
    level: 1
    flags: "warning"

  error:
    color: "red"
    level: 2
    flags: "error"

