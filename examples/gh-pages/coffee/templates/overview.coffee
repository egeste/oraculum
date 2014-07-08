define [
  'cs!app'
  'cs!app/libs'
  'text!md/architecture.md'
  'text!md/factoryjs-composition.md'
  'text!md/chaplin-lifecycle.md'
  'text!md/oraculum-core.md'
], (Dox, stub, args...) ->

  return Dox.get('concatTemplate') args...
