var colors, dateFormat, events, log_event, nFn, options;

log_event = function(options) {
  this.flags = options.flags;
  this.level = options.level || 0;
  return this.color = options.color || "green";
};

dateFormat = require("dateformat");

colors = require("colors");

events = {};

options = {
  level: 0,
  format: "%timestamp% - %flags%:%padding%  %message%",
  timestamp: "HH:MM:ss"
};

log_event.prototype.config = function(config) {
  var key;
  for (key in config) {
    if (config.hasOwnProperty(key)) {
      this[key] = config[key];
    }
  }
  return this;
};

log_event.prototype.__defineGetter__("padding", function() {
  var i, key, length, padding;
  length = 0;
  padding = "";
  for (key in events) {
    if (events.hasOwnProperty(key)) {
      length = (length < events[key].flags.length ? events[key].flags.length : length);
    }
  }
  i = 0;
  while (i < length - this.event.length) {
    padding += " ";
    i++;
  }
  return padding;
});

log_event.prototype.output = function(input) {
  var format, i, message, output;
  if (options.level <= this.level) {
    message = "";
    for (i in input) {
      if (input.hasOwnProperty(i)) {
        message += " " + (typeof input[i] === "object" ? JSON.stringify(input[i], null) : input[i]);
      }
    }
    format = this.format || options.format;
    output = format.replace("%timestamp%", dateFormat(new Date(), this.timestamp || options.timestamp)).replace("%flags%", this.flags[this.color]).replace("%padding%", this.padding).replace("%message%", message);
    return console.log(output);
  }
};

exports.config = function(config) {
  var key;
  for (key in config) {
    if (options.hasOwnProperty(key)) {
      options[key] = config[key];
    }
  }
  return this;
};

nFn = function(e) {
  return function() {
    if (arguments_.length === 0) {
      return events[e];
    } else {
      return events[e].output(arguments_);
    }
  };
};

exports.custom = function(newEvents) {
  var flags;
  for (flags in newEvents) {
    if (newEvents.hasOwnProperty(flags)) {
      events[flags] = new log_event(newEvents[flags]);
    }
    this[flags] = nFn(flags);
  }
  return this;
};

exports.custom({
  info: {
    color: "green",
    level: 0,
    flags: "info"
  },
  warn: {
    color: "yellow",
    level: 1,
    flags: "warning"
  },
  error: {
    color: "red",
    level: 2,
    flags: "error"
  }
});
