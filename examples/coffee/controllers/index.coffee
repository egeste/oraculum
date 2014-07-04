define [
  'cs!app'

  'text!md/overview.md'
  # 'text!md/getting-started.md'
  # 'text!md/advanced-techniques.md'

  'oraculum/application/controller'

  'cs!app/views/markdown'

  'cs!app/controllers/mixins/nav-composer'
], (Dox, overview, gettingStarted, advancedTechniques) ->
  'use strict'

  Dox.extend 'Controller', 'Index.Controller', {

    index: ->
      # A simple redirect. Will result in a url change.
      @redirectTo 'Index.Controller#overview'

    'overview': ->
      @view = @__factory().get 'Markdown.View',
        region: 'info'
        template: overview

    'getting-started': ->
      console.log 'gettingStarted'

    'advanced-techniques': ->
      console.log 'advancedTechniques'

  }, {
    inheritMixins: true
    mixins: [
      'NavComposer.ControllerMixin'
    ]
  }
