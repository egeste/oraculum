define [
  'cs!app'
  'cs!app/libs'
  'cs!app/views/mixins/scroll-spy'
  'oraculum/mixins/pub-sub'
  'oraculum/mixins/listener'
  'oraculum/views/mixins/layout'
], (Dox) ->
  'use strict'

  $ = Dox.get 'jQuery'

  Dox.extend 'View', 'Dox.Layout', {
    el: document.body

    mixinOptions:
      layout:
        scrollTo: false
      regions:
        info: '#info'
        navbar: '#navbar'
        sidebar: '#sidebar'
      listen:
        '!refreshOffsets mediator': '_refreshPlugins'

    initialize: ->
      @addWindowEvents()

    _refreshPlugins: ->
      highlight = @__factory().get 'highlight'
      @$('pre code').each (i, el) ->
        highlight.highlightBlock el

    addWindowEvents: ->
      $(window, document).on 'resize', _.debounce (=>
        @publishEvent '!refreshOffsets'
      ), 100

  }, mixins: [
    'PubSub.Mixin'
    'Listener.Mixin'
    'Layout.ViewMixin'
    'ScrollspyViewport.ViewMixin'
  ]
