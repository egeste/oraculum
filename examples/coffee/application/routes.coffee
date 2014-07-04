define [
  'cs!app'
  'cs!app/models/pages'
  'cs!app/controllers/index'
], (Dox) ->
  'use strict'

  Dox.define 'routes', ->

    # Grab our pages singleton
    pages = @__factory().get 'Pages.Collection'

    return (match) ->
      # Match no url ('/', root)
      match '', 'Index.Controller#index'

      # Allow our pages singleton to define what routes are available
      pages.each ({id}) -> match id, "Index.Controller##{id}"

      # Don't use a catchall. It will mess up our href IDs
