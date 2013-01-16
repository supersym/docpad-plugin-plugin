###
Program blueprint
=================

This file renders into a command line executable application and was written to
automate a certain amount of the work involved in properly setting up a plugin,
much like a boilerplate/template system backed up by a single, powerful, CLI program.

Project members may come and go while DocPad, inherent to the open-source approach,
may have to put some extra effort in ironing out the potentially very different
approaches one would take when developing in loosely based groups to do collaborative
work. We can't assume everyone to hold the same standards, accuracy or level of
(more deeply) understanding the DocPad inner workings at the core.

So let's have a machine do the hard work for us! ###

# enum plugin types: renderer, mashed-up (upstreams!), informational (notify etc)
# support, language

###
Dependencies
###
program = require "commander"
fs      = require "fs"
colors  = require "colors"

colors.setTheme
  input: 'grey'
  verbose: 'cyan'
  prompt: 'grey'
  info: 'green'
  data: 'grey'
  help: 'cyan'
  warn: 'yellow'
  debug: 'blue'
  error: 'red'

# outputs red text
console.log("this is an error".error);

# outputs yellow text
console.log("this is a warning".warn);


program

  # Program header / meta-data
  .version "0.0.1"

  # Arguments:
  # expect some form of information to be provided other than just yes/no ###

  # Specifies which template file to use for scaffolding of a plugin
  .option "-t, --template <file>", "Add a template to create a plugin from"

  # Handy to support multiple plugins (modules, .plugin.coffee files) under the same project roof
  .option "-o, --outdir <path>", "The directory path in which we publish or use the folder src/"

  # You would be able to define a 'minimal', 'normal' or 'complete' package.json to return
  # We would not have to generate tons of questions and fields that aren't going to be used
  .option "-p, --pkg <enum>", "Regulate amount of questions to ask and package.json fields to support (default: normal)"

  # Size of the project team, among others related to the generation of fields like "contributors"
  .option "-c, --collab <quantity>", "The size of the development team working on this project, default is one (1)"


  ###
  Switches
  --------
  These are boolean data type flags that switch on/off, enable or disable features. Limited by it's nature to only
  deal with zero's and one's as input and used for clear-cut cases where we want to constrain developer freedom some more.  ###

  # Allow some freedom to have tests included early on, for drafts/demos this might not be wanted/needed
  .option "-T, --testable", "Set up a testing environment under directory test/"

  # Parse the process (app) arguments being fed
  .parse process.argv

###
Commands
========

Subcommand `new`
----------------

The rationale behind a whole own subcommand is first of all, that we have several
types of 'new' entities to support. Like:

@example Create a new plugin container project, files and github repository
  $ docpad-plugins new

@example Create a new (set of) plugin file(s) based on optionally, a template
  $ docpad-plugins new plugin

@example Create a new skeleton to build a different new template on
  $ docpad-plugins new template

###



program

  # TODO: figure out how to further specify this
  # On the subcommand 'new' being issued, optionally expect a entity in the form of a string (enum)
  .command 'new [entity]'
  .description 'creates new instances of the entity'

  # Operations when issued
  .action (entity) ->

    # Create a new project in any folder except one recognized as a 'plugin' container
    #Error 'Cannot create a project inside a project'  if fs.existsSync('bin/docpad-plugins') and entity == 'project'
    #createProject()
    # Set the entity variable or, if no value was passed, just create a plugin
    entity = entity || 'plugin'

    # The only options left are
    # else

    # Error

    console.log 'Constructing a new %s', entity

console.log "you ordered a pizza with:"
console.log "  - peppers"  if program.peppers
console.log "  - pineapple"  if program.pineapple
console.log "  - bbq"  if program.bbq

testable is true === program.testable
  ? "marble"
  : program.cheese || "no"

console.log "  - %s cheese", cheese
console.log program.args
