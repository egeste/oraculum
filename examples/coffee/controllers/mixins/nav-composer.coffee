define [
  'cs!app'
  'cs!app/models/pages'
  'cs!app/views/navbar'
  'oraculum/mixins/evented-method'
], (Dox) ->
  'use strict'

  Dox.defineMixin 'NavComposer.ControllerMixin', {

    mixinOptions:
      eventedMethods:
        beforeAction: {}

    mixinitialize: ->
      @on 'beforeAction:before', @composeNavbar, this

    composeNavbar: (params, {path}) ->
      pages = @__factory().get 'Pages.Collection'
      pages.setActive path if path
      @reuse 'navbar', 'Navbar.View',
        region: 'navbar'
        collection: pages

  }, mixins: [
    'EventedMethod.Mixin'
  ]
