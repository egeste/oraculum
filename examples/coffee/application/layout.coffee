define [
  'cs!app'
  'oraculum/views/mixins/layout'
], (Dox) ->
  'use strict'

  Dox.extend 'View', 'Dox.Layout', {
    el: '#content'

    mixinOptions:
      regions:
        info: '#info'
        navbar: '#navbar'
        sidebar: '#sidebar'

  }, mixins: [
    'Layout.ViewMixin'
  ]
