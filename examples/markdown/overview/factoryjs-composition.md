### FactoryJS Composition
-------------------------

<a href="examples/images/FactoryJS%20Composition%20Architecture.jpg" class="thumbnail pull-right col-xs-12 col-sm-4 col-md-3 text-center" target="_blank">
  <img src="examples/images/FactoryJS%20Composition%20Architecture.jpg" alt="The FactoryJS Composition Architecture"/>
  <small>The FactoryJS Composition Architecture</small>
</a>

Unlike any of psuedo classical inheritance mechanisms provided by other javascript frameworks or transpilers, Oraculum uses FactoryJS to perform object composition. This adds a critical layer of flexibility allowing object definition, extension, and overriding without mutating underlying prototypes. This means that your application can be modified, extended, or otherwise altered without affecting other parts of the system or losing the original definition. This is incredibly useful for adding and removing functionality from an existing application, or simply modifying an application's behavior, without ever having to touch the application's underlying code.

Oraculum relies on this property of FactoryJS via BackboneFactory to provide an altered `Model`, `Collection`, and `View` definition that allows referencing factory definitions by name, without modifying Backbone's `Model`, `Collection`, or `View` prototypes. If you want to, you can continue to use all of Backbone's classes like you normally would alongside Oraculum definitions.

<div class="clearfix"></div>

#### Example: Referencing factory definitions by name.
------------------------------------------------------
```coffeescript
# Create a simple definition based on the Model definition.
# The provided definition will be extended onto the base definition when an
# instance is requested from the factory.
Oraculum.extend 'Model', 'Custom.Model', {

  # Provide a simple method to illustrate that the instance gets composed.
  quack: -> console.log 'quack', @id

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
singleton.add id: 1
singleton.add id: 2
singleton.add id: 3

# Invoke quack to show that all of our additions have resolved to model
# instances.
singleton.quack()


# Create a new view (modified Backbone.View), passing our singleton definition
# name as the collection.
view = Oraculum.get 'View',
 collection: 'Singleton.Collection'

# Show that the view's collection has resolved to the same instance as our
# previous singleton.
console.log 'Singleton resolved?', view.collection is singleton
```
To learn more about FactoryJS, check out the [Lookout Hackers blog.](http://hackers.lookout.com/2014/03/factoryjs/)
