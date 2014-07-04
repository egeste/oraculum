define [
  'cs!app'
], (Dox) ->
  'use strict'

  Dox.extend 'View', 'Sidebar.View', {

  }, mixins: [
    'List.ViewMixin'
  ]
