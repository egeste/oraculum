define [
  'cs!app'
  'cs!app/libs'
  'cs!app/views/mixins/scroll-spy'
  'oraculum/mixins/listener'
  'oraculum/views/mixins/layout'
], (Dox) ->
  'use strict'

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

    _refreshPlugins: ->
      highlight = @__factory().get 'highlight'
      @$('pre code').each (i, el) ->
        highlight.highlightBlock el

  }, mixins: [
    'Listener.Mixin'
    'Layout.ViewMixin'
    'ScrollspyViewport.ViewMixin'
  ]
