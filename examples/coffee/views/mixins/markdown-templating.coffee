define [
  'cs!app'
  'cs!app/libs'
  'oraculum/views/mixins/templating-interface'
], (Dox) ->
  'use strict'

  Dox.defineMixin 'MarkdownTemplating.ViewMixin', {

    render: ->
      marked = @__factory().get 'marked'
      template = @mixinOptions.template
      template = template.call this if typeof template is 'function'
      @$el.html marked template
      return this

  }, mixins: [
    'TemplatingInterface.ViewMixin'
  ]
