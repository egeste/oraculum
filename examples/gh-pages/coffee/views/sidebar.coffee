define [
  'cs!app'
  'cs!app/libs'

  'oraculum/mixins/pub-sub'
  'oraculum/mixins/listener'
  'oraculum/mixins/disposable'

  'oraculum/views/mixins/list'
  'oraculum/views/mixins/auto-render'
  'oraculum/views/mixins/region-attach'
  'oraculum/views/mixins/static-classes'
  'oraculum/views/mixins/html-templating'
  'oraculum/views/mixins/remove-disposed'

  'cs!app/views/mixins/affix'
  'cs!app/views/mixins/scroll-spy'
], (Dox) ->
  'use strict'

  $ = Dox.get 'jQuery'
  marked = Dox.get 'marked'

  Dox.extend 'View', 'SidebarItem.View', {
    tagName: 'li'
    events:
      'click a': ->
        selector = "[id=\"#{@model.id}\"]"
        @publishEvent '!scrollTo', selector, 500
        return false

    mixinOptions:
      staticClasses: ['sidebar-item-view']
      template: -> """
        <a href="##{@model.id}">
          #{@model.get 'name'}
        </a>
      """

  }, mixins: [
    'PubSub.Mixin'
    'Disposable.Mixin'
    'HTMLTemplating.ViewMixin'
  ]

  Dox.extend 'View', 'Sidebar.View', {
    tagName: 'ul'
    className: 'nav'

    mixinOptions:
      staticClasses: ['sidebar-view']
      list:
        modelView: 'SidebarItem.View'

  }, mixins: [
    'Disposable.Mixin'
    'List.ViewMixin'
    'Affix.ViewMixin'
    'RegionAttach.ViewMixin'
    'StaticClasses.ViewMixin'
    'RemoveDisposed.ViewMixin'
    'ScrollspyTarget.ViewMixin'
    'AutoRender.ViewMixin'
  ]
