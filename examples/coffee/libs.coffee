define [
  'cs!app'
  'marked'
  'highlight'
  'oraculum/libs'
], (Dox, marked, highlight) ->
  'use strict'

  Dox.define 'marked', (-> marked), singleton: true
  Dox.define 'highlight', (-> highlight), singleton: true
