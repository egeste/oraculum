define [
  'cs!app'
  'marked'
  'oraculum/libs'
], (Dox, marked) ->
  'use strict'

  Dox.define 'marked', (-> marked), singleton: true
