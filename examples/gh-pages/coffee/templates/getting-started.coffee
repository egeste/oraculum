define [
  'cs!app'
  'cs!app/libs'
  'text!md/getting-started.md'
  'text!md/dependencies.md'
  'text!md/aspect-oriented-programming.md'
], (Dox, stub, args...) ->

  return Dox.get('concatTemplate') args...
