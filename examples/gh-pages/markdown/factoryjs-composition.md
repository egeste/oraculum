FactoryJS
---------
---------

<a href="examples/gh-pages/images/FactoryJS%20Composition%20Architecture.jpg" class="thumbnail pull-right col-sm-4 col-md-3 text-center" target="_blank">
  <img src="examples/gh-pages/images/FactoryJS%20Composition%20Architecture.jpg" alt="The FactoryJS Composition Architecture"/>
  <small>The FactoryJS Composition Architecture</small>
</a>

Unlike any of psuedo classical inheritance mechanisms provided by other javascript frameworks or compilers, Oraculum uses FactoryJS to perform object composition. This adds a critical layer of flexibility allowing object definition, extension, and overriding without mutating underlying prototypes. This means that your application can be modified, extended, or otherwise altered without affecting other parts of the system or losing the original definition. This is incredibly useful for adding and removing functionality from an existing application, or simply modifying an application's behavior, without ever having to touch the application's underlying code.

Oraculum relies on this property of FactoryJS via BackboneFactory to provide an altered `Model`, `Collection`, and `View` definition that allows referencing factory definitions by name, without modifying Backbone's `Model`, `Collection`, or `View` prototypes. If you want to, you can continue to use all of Backbone's classes like you normally would alongside Oraculum definitions.

<div class="clearfix"></div>

<div class="panel panel-default">
  <div class="panel-heading">
    <h4 class="panel-title">
      <a href="javascript:void(0);" data-collapse-target="#example-ref-def-by-name">
        Example: Referencing factory definitions by name
      </a>
    </h4>
  </div>
  <div id="example-ref-def-by-name" class="panel-collapse collapse">
    <pre><code class="coffeescript">
# Create a simple definition based on the Model definition.
# The provided definition will be extended onto the base definition when an
# instance is requested from the factory.
Oraculum.extend 'Model', 'Custom.Model', {

  # Provide a simple method to illustrate that the instance gets composed.
  quack: -> alert ['quack', @id].join ' '

}

# Create another simple definition based on the Collection definition.
Oraculum.extend 'Collection', 'Singleton.Collection', {
  # Reference our custom model definition by name as a string.
  # It will automagically get resolved to a factory definition constructor.
  model: 'Custom.Model'

  # Provide a simple method to illustrate that the instance gets composed.
  quack: -> @invoke 'quack'

# Make this definition a singleton.
# After the first time this definition has been constructed, all other requests
# for this definition will return the same instance.
}, singleton: true

# Request an instance of our Singleton.Collection definition so we can add some
# models to it.
singleton = Oraculum.get 'Singleton.Collection'
singleton.add id: 1, name: 'Duck'
singleton.add id: 2, name: 'Mallard'
singleton.add id: 3, name: 'Ugly Duckling'

# Invoke quack to show that all of our additions have resolved to model
# instances.
singleton.quack()

# Create a new view (modified Backbone.View), passing our singleton definition
# name as the collection.
view = Oraculum.get 'View',
 collection: 'Singleton.Collection'

# Show that the view's collection has resolved to the same instance as our
# previous singleton.
alert ['Singleton resolved?', view.collection is singleton].join ' '

# Continued in the next example...
    </code></pre>
  </div>
</div>

This allows Oraculum applications to be largely reduced to configuration. We refer to these types of configuration definitions as a `Flyweight`. `Flyweight`s can be thought of as a configuration manifest that instruct the `Factory` to stitch together `Definition`s and `Mixin`s.

<div class="panel panel-default">
  <div class="panel-heading">
    <h4 class="panel-title">
      <a href="javascript:void(0);" data-collapse-target="#example-flyweight">
        Example: Factories, Flyweights &amp; Mixins
      </a>
    </h4>
  </div>
  <div id="example-flyweight" class="panel-collapse collapse">
    <pre><code class="coffeescript">
# Continued from the previous example...

# Create a simple view to render one of our models
Oraculum.extend 'View', 'Item.View', {
  tagName: 'li' # understood by Backbone.View
  className: 'item' # understood by Backbone.View

  # mixinOptions allows the configuration of applied mixins
  mixinOptions:
    # In this case we're configuring HTMLTemplating.ViewMixin.
    # Templates can be a string or a function that returns a string.
    template: -> @model.escape 'name'

}, mixins: [
  # @see views/mixins/html-templating.coffee
  'HTMLTemplating.ViewMixin'
]

# Create a list view to render our collection
Oraculum.extend 'View', 'List.View', {
  tagName: 'ul' # understood by Backbone.View
  className: 'list' # understood by Backbone.View

  mixinOptions:
    # Here we're configuring List.ViewMixin
    list:
      # Tell the mixin to use our defined Item.View to render models
      modelView: 'Item.View'

}, mixins: [
  # @see views/mixins/list.coffee
  'List.ViewMixin'
  # @see views/mixins/auto-render.coffee
  'AutoRender.ViewMixin'
]
    </code></pre>
  </div>
</div>

Using the concepts of `Factories` `Flyweight`s and `Mixin`s, using 0 lines of logic, we're able to create a `View` that will render a `<ul>` which represents our `Collection`. The behavior provided by `List.ViewMixin` will render each `Model` in the `Collection` as an `<li>` containing the name attribute of the `Model`.

FactoryJS is the heart of Oraculum. At its core, Oraculum is nothing more than a set of definitions that emulates `Chaplin`'s MVC lifecycle, and a library of `Mixin`s that solve the most common use cases.

<small class="pull-right">
  To learn more about FactoryJS, check out [The Lookout Hackers blog](http://hackers.lookout.com/2014/03/factoryjs/)
</small>