
###
Flat language/technology boilerplate files to be used elsewhere
###

https = require 'https'

url =

  # Standard documents without headers, footers etc. dynamically included
  html5bp: 'https://raw.github.com/h5bp/html5-boilerplate/master/index.html'

  # Semantic grid system (semantic.gs)
  semgsfixed: 'https://raw.github.com/dmmalam/semantic.gs/master/stylus/examples/fixed/fixed.styl'
  semgsfluid: 'https://raw.github.com/dmmalam/semantic.gs/master/stylus/examples/fluid/fluid.styl'
  semgsmaxw: 'https://raw.github.com/dmmalam/semantic.gs/master/stylus/examples/maxwidth/maxwidth.styl'
  semgsnest: 'https://raw.github.com/dmmalam/semantic.gs/master/stylus/examples/nested/nested.styl'




https.get(url.semgsfluid, (res) ->
  console.log res.statusCode
  console.log res.headers

  res.on 'data', (d) ->
    process.stdout.write d

).on 'error', (e) ->

  console.error e





