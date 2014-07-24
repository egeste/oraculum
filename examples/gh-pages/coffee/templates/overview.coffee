define [
  'cs!app'
  'cs!app/libs'
  'text!md/architecture.md'
  'text!md/factoryjs-composition.md'
  'text!md/oraculum-application.md'
  'text!md/oraculum-behaviors.md'
], (Dox, stub, args...) ->

  return Dox.get('concatTemplate') args...
