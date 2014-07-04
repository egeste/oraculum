define [
  'cs!app'
], (Dox) ->
  'use strict'

  # Create a singleton collection that will store all our available pages
  Dox.extend 'Collection', 'Pages.Collection', {

    setActive: (id) ->
      @invoke 'unset', 'active'
      @get(id).set active: true

  }, singleton: true

  # Hydrate the singleton with our available pages
  Dox.get 'Pages.Collection', [{
    id: 'overview'
    name: 'Overview'
  }, {
    id: 'getting-started'
    name: 'Getting Started'
  }, {
    id: 'advanced-techniques'
    name: 'Advanced Techniques'
  }]
