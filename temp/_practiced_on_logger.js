
/*global require */

var dateFormat = require('dateformat');
var colors = require('colors');

var events = { };

var options = {
         level: 0,
         format: "%timestamp% - %flags%:%padding%  %message%",
         timestamp: "HH:MM:ss"
    };

function log_event(options) {
    this.flags = options.flags;
    this.level = options.level || 0;
    this.color = options.color || 'green';
}

log_event.prototype.config = function (config) {
    for (var key in config) {
        if (config.hasOwnProperty(key)) {
            this[key] = config[key];
        }
    }
  return this;
};

log_event.prototype.__defineGetter__ ('padding', function() {
  var length = 0;
  var padding = '';
  for (var key in events) {
    if(events.hasOwnProperty(key)) {
        length = length < events[key].flags.length ? events[key].flags.length : length;
    }
  }
  for (var i=0; i<length-this.event.length; i++)
  {
    padding += ' ';
  }
  return padding;
});

log_event.prototype.output = function(input) {
  if (options.level <= this.level) {
    var message = '';
    for (var i in input) {
      if (input.hasOwnProperty(i)) {
          message += " " + ( typeof input[i] === "object" ? JSON.stringify( input[i], null ) : input[i] );
      }
    }
    var format = this.format || options.format;
    output = format
      .replace( '%timestamp%', dateFormat( new Date(), this.timestamp || options.timestamp ) ) //timestamp
      .replace( '%flags%', this.flags[ this.color ] ) //log event & color
      .replace( '%padding%', this.padding )
      .replace( '%message%', message );
    console.log( output );
  }
};

exports.config = function( config ) {
  for (var key in config) {
    if(options.hasOwnProperty(key)) {
       options[key] = config[key];
    }
  }
  return this;
};



var nFn = function(e) {
  return function() {
    if (arguments.length === 0) {
      return events[e];
    }
    else
    {
      events[e].output(arguments);
    }
  };
};

exports.custom = function(newEvents) {
  for (flags in newEvents) {
    if (newEvents.hasOwnProperty(flags)) {
        events[flags] = new log_event(newEvents[flags]);
    }
    this[flags] = nFn(flags);
  }
  return this;
};

exports.custom({
  info: { color: 'green', level: 0, flags: 'info' },
  warn: { color: 'yellow', level: 1, flags: 'warning' },
  error: { color: 'red', level: 2, flags: 'error' }
});
