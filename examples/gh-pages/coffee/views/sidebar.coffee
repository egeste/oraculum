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

    mixinOptions:
      staticClasses: ['sidebar-item-view']
      template: -> """
        <a href="##{@model.id}">
          #{@model.get 'name'}
        </a>
      """

  }, mixins: [
    'Disposable.Mixin'
    'HTMLTemplating.ViewMixin'
  ]

  Dox.extend 'View', 'Sidebar.View', {

    events:
      'click [href="#top"]': '_scrollTop'
      'click .next:not([disabled])': '_next'
      'click .prev:not([disabled])': '_prev'

    mixinOptions:
      staticClasses: ['sidebar-view']
      list:
        modelView: 'SidebarItem.View'
        listSelector: 'ul.nav'
      scrollspy:
        target: '.sidebar-view'
      template: '''
        <ul class="nav"/>
        <ul class="pagination pagination-sm">
          <li>
            <a href="javascript:void(0);" class="prev">
              &laquo; Previous
            </a>
          </li>
          <li>
            <a href="#top" rel="external">
              ^ Top
            </a>
          </li>
          <li>
            <a href="javascript:void(0);" class="next">
              Next &raquo;
            </a>
          </li>
        </ul>
      '''

    _next: ->
    _prev: ->

    _scrollTop: (e) ->
      e.preventDefault()
      e.stopPropagation()
      @publishEvent '!scrollTo', '#top', 500
      return false

  }, mixins: [
    'PubSub.Mixin'
    'Disposable.Mixin'
    'EventedMethod.Mixin'
    'List.ViewMixin'
    'Affix.ViewMixin'
    'RegionAttach.ViewMixin'
    'StaticClasses.ViewMixin'
    'RemoveDisposed.ViewMixin'
    'HTMLTemplating.ViewMixin'
    'ScrollspyTarget.ViewMixin'
    'AutoRender.ViewMixin'
  ]
