define [
  'cs!app'
  'gist-embed'
  'oraculum/mixins/evented-method'
], (Dox) ->
  'use strict'

  Dox.defineMixin 'GistEmbed.ViewMixin', {

    mixinOptions:
      eventedMethods:
        render: {}

    mixinitialize: ->
      @on 'render:after', @_gistEmbed, this

    _gistEmbed: ->
      @$('[data-gist-id]').gist()

  }, mixins: [
    'EventedMethod.Mixin'
  ]
