

# Derived from the post made by thomasb on Mar 5th, 2012 at
# http://www.gridlinked.info/oop-with-coffeescript-javascript/

# Boilerplate file for quickly bootstrapping CoffeeScript higher-level order of
# abstraction through the use of OOP techniques, probably will be a egg-chicken

# A abstract class to use as a base model for defining common attributes of -
# usually physical real world inspired - other entities within our domain model.

### @TODO: this should come from a special glossary written in overview programming
# style of tone as to point out way CS sees 'abstract' and 'classes' etc. ###

#
class BaseEntity

  ###
  Creates the instance of the class, a in-memory object representation
  @example How to construct a workable object from a class to execute a method?
    myObjVar = new ClassEntity "the-name"
    myObjVar.someMethod()
  ###
  constructor: (@name) ->
    Error "failed construction"  if err
    console.log "Created a instance of the class...OK"

class NotFound extends Error

