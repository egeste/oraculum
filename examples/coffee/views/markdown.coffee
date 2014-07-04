define [
  'cs!app'
  'cs!app/libs'

  'cs!app/views/mixins/markdown-templating'

  'oraculum/mixins/disposable'
  'oraculum/views/mixins/auto-render'
  'oraculum/views/mixins/region-attach'
  'oraculum/views/mixins/remove-disposed'
], (Dox) ->
  'use strict'

  $ = Dox.get 'jQuery'

  Dox.extend 'View', 'Markdown.View', {}, mixins: [
    'Disposable.Mixin'
    'RegionAttach.ViewMixin'
    'RemoveDisposed.ViewMixin'
    'MarkdownTemplating.ViewMixin'
    'AutoRender.ViewMixin'
  ]
