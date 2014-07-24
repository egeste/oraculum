<!--
Oraculum definitions/mixins
  What's provided
    MVC components
    AOP hooking (makeEventedMethod, makeMiddlewareMethod)
    Behavior library
-->

Oraculum Application
--------------------
--------------------

<a href="examples/gh-pages/images/Oraculum%20Application%20Components.jpg" class="thumbnail pull-right col-sm-4 col-md-3 text-center" target="_blank">
  <img src="examples/gh-pages/images/Oraculum%20Application%20Components.jpg" alt="Oraculum Application Components"/>
  <small>Oraculum Application Components</small>
</a>

Oraculum's core application definitions and mixins are ported from concepts in Chaplin. Like Chaplin, Oraculum provides the following classes:

  * Application
  * Controller
  * Dispatcher
  * Composer
    * Composition
  * Router (improved)
    * Route
  * History (improved)

The application lifecycle is the same between Chaplin and Oraculum. The only significant difference is Oraculum's use of FactoryJS to resolve classes and inject behaviors. Because of this, the mixins used in Oraculum's core application components are available to any definition that wants to use them. This includes mixins for publishing/subscribing to a global event bus, making objects disposable in a memory-safe way, freezing objects after construction, and several others.

<div class="clearfix"></div>

#### Example: Oraculum Application
----------------------------------
```coffeescript
# Create a routes function to handle our routing
routes = (match) ->
  # The matching syntax is the same as Chaplin's however, the route spec
  # syntax is different.
  # This is because we can reference objects by name in the factory.
  match '*url', 'Index.Controller#main'

# Remember that route spec we used in our routes file?
# Let's create a controller that matches it.
# @see https://github.com/chaplinjs/chaplin/blob/master/docs/chaplin.controller.md
Oraculum.extend 'Controller', 'Index.Controller', {

  # This is our main `Action`
  main: ->
    # @see https://github.com/chaplinjs/chaplin/blob/master/docs/chaplin.composer.md
    @reuse 'list', 'List.View',
      region: 'example' # Use the 'example' region in our layout.
      collection: 'Singleton.Collection' # The factory will resolve this.

}, inheritMixins: true

# Just like in Chaplin, we need a layout.
# A layout is just a view that uses `Layout.ViewMixin`
Oraculum.extend 'View', 'Custom.Layout', {
  # The Layout is essentially the top-level view of your application.
  # Most of the time, your layout is going to be attached to document.body
  el: document.body

  mixinOptions:
    # Layout.Mixin automatically adds RegionPublisher.ViewMixin
    # Allowing us to create new "regions"
    # @see views/mixins/region-publisher
    regions:
      # A common task for a layout is to publish named regions.
      example: '#example'

}, mixins: [
  # @see views/mixins/layout.coffee
  'Layout.ViewMixin'
]

# Finally, we can stitch it all together in our `Application`
# @see application/index.coffee
Oraculum.get 'Application',
  layout: 'Custom.Layout' # The factory will resolve this for you
  routes: routes
```

If you're already familiar with Chaplin, this will look familiar to you. Aside from the implementation details in the underlying classes, and the named definition resolution, this is almost exactly the same as Chaplin 1.1.x. However, just like in Chaplin, these components are completely optional and aren't required to use Oraculum.

<small class="pull-right">
  To learn more about Chaplin, check out [ChaplinJS.org](http://chaplinjs.org/)
</small>
