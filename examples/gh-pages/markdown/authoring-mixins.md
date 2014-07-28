Authoring `Mixin`s
----------------
----------------
While the `mixin`s provided by Oraculum should be able to solve a large portion of common challenges, there will inevitably be application or domain-specific challenges that are not covered. When you discover these, feel free to author your own custom `mixin`s to solve them. Authoring `mixin`s for Oraculum is easy to do, and when done correctly can often be contributed back to the open source community.

#### Aspect Oriented Programming
--------------------------------

The first thing to know before you start writing your own `mixin`s and `definition`s is how Oraculum approchaes inheritance. JavaScript provides no native inheritance mechanism. Any prior experience you may have with the concept of inheritance in JavaScript is based on iterating over an object and copying members from that object to another. This approach can enable similar behavior to classical inheritance, but lacks many features of classical inheritance, such as referencing parent members, calling super() on a method, interfaces, abstract classes, etc. Again, many libraries, and even CoffeeScript, attempt to emulate these behaviors, but in most cases this approach tends to lead to very tightly coupled behavior with frequent mutation of object prototypes.

There _is_ an simple answer dear friend!

Instead of relying on faux classical inheritance for modifying an object's prototype, Oraculum provides two utilities: `makeEventedMethod`, and `makeMiddlewareMethod`. These utilities create a wrapped version of a target function that emit `:before` and `:after` events on a target event emitter.
Oraculum also provides this functionality as a `mixin` via `EventedMethod.Mixin` and `MiddlewareMethod.Mixin`, which allow methods to be wrapped immediately after an object is constructed.

`makeEventedMethod` and `makeMiddlewareMethod` are how Oraculum handles the problem of shallow composition over deep inheritance, and they form the heart of Oraculum's AOP-based logic decoupling.

#### Example: Hooking `View.render()`
-------------------------------------
```coffeescript
# Create a `definition` that uses `EventedMethod.Mixin`
Oraculum.extend 'View', 'Alert.View', {

  mixinOptions:
    # Configure the `EventedMethod.Mixin` to wrap the render method.
    eventedMethods:
      render: {}

  # Add event listeners to the method's new hooks.
  initialize: ->
    @on 'render:before', -> alert 'Alert.View::render started'
    @on 'render:after', -> alert 'Alert.View::render completed'

}, mixins: [
  'EventedMethod.Mixin'
]

# Create a new instance of our view and invoke render.
view = Oraculum.get 'Alert.View'
view.render()
```

This even works with targeting methods provided by other `mixin`s, provided those `mixin`s are injected before `EventedMethod.Mixin`.

#### Example: Hooking `mixin` methods
-------------------------------------
```coffeescript
Oraculum.defineMixin 'Some.Mixin',

  # Create a new to extend onto an instance.
  someMethod: -> alert 'Some Method'

# Create a `definition` that uses our new `mixin`.
Oraculum.extend 'View', 'Some.View', {

  mixinOptions:
    # Configure the `EventedMethod.Mixin` to wrap our provided method.
    eventedMethods:
      someMethod: {}

  # Add event listeners to the method's new hooks.
  initialize: ->
    @on 'someMethod:before', -> alert 'Some.View::someMethod started'
    @on 'someMethod:after', -> alert 'Some.View::someMethod completed'

}, mixins: [
  'Some.Mixin'
  'EventedMethod.Mixin'
]

# Create a new instance of our view and invoke the method.
view = Oraculum.get 'Some.View'
view.someMethod()
```

And just in case you weren't sold yet, you can even hook methods of other `mixin`s from within a `mixin`.

#### Example: Hooking `mixin` dependency methods
----------------------------------------------
```coffeescript
Oraculum.defineMixin 'SomeOther.Mixin', {

  mixinOptions:
    # Configure the `EventedMethod.Mixin` to wrap our provided method.
    eventedMethods:
      someMethod: {}

  # Add event listeners to the method's new hooks.
  mixinitialize: ->
    @on 'someMethod:before', -> alert 'SomeOther.Mixin::someMethod started'
    @on 'someMethod:after', -> alert 'SomeOther.Mixin::someMethod completed'

}, mixins: [
  'Some.Mixin'
  'EventedMethod.Mixin'
]

# Create a `definition` that uses our new `mixin` chain.
Oraculum.extend 'View', 'SomeOther.View', {}, mixins: [
  'SomeOther.Mixin'
]

# Create a new instance of our view and invoke the method.
view = Oraculum.get 'SomeOther.View'
view.someMethod()
```

#### Importance of Mixin Order
------------------------------

The order in which you specify your `mixin`s is important. In the `Hooking `mixin` methods` example we are careful to use `Some.Mixin` _before_ `EventedMethod.Mixin` so that when `EventedMethod.Mixin` gets initialize, all of `Some.Mixin`'s methods are available to wrap. Failing to consider the order of your `mixin`s, or failing to include a `mixin`, are the most common type of error you are likely to encounter when developing applications in Oraculum. These errors can be easily fixed by reordering your `mixin`s, or simply adding the missing `mixin`. As you continue to work with Oraculum, you will discover that the vast majority of bugs discovered in your application will be logicless misconfiguration, and can be fixed trivially.
