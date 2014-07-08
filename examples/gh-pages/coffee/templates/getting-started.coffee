define [
  'cs!app'
  'cs!app/libs'
  'text!md/dependencies.md'
], (Dox, stub, args...) ->

  return Dox.get('concatTemplate') args...
