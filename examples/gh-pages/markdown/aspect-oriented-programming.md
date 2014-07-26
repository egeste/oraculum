<!--
Getting Started
  Basics
    Create a simple Model with mixins
    Create a simple View with mixins
  Application
    Create a layout
    Create a routes file
    Create a controller
    Wire it all up
  Provided interfaces
  Creating custom mixins
-->

Aspect Oriented Programming
---------------------------
---------------------------

The first thing to know before you start writing your own `mixin`s and `definition`s is how Oraculum approchaes inheritance. JavaScript provides no native inheritance mechanism. Any prior experience you may have with the concept of inheritance in JavaScript is based on iterating over an object and copying members from that object to another. This approach can enable similar behavior to classical inheritance, but lacks many features of classical inheritance, such as referencing parent members, calling super() on a method, interfaces, abstract classes, etc. Again, many libraries, and even CoffeeScript, attempt to emulate these behaviors, but in all cases this approach tends to lead to very tightly coupled behavior with frequent mutation of object prototypes.

There _is_ an simple answer dear friend!

Instead of relying on faux classical inheritance for modifying an object's prototype, Oraculum provides two utilities: `makeEventedMethod`, and `makeMiddlewareMethod`. These utilities create a wrapped version of a target function that emit `:before` and `:after` events on a target event emitter.
Oraculum also provides this functionality as a mixin via `EventedMethod.Mixin` and `MiddlewareMethod.Mixin`, which allow methods to be hooked immediately after an object is constructed.

`makeEventedMethod` and `makeMiddlewareMethod` form the heart of how Oraculum handles the problem of shallow composition over deep inheritance. Because FactoryJS supports mixin dependencies, any mixin can require `EventedMethod.Mixin` and target any method on the definition.

#### Example: Hooking `View.render()`
-------------------------------------
```coffeescript
Oraculum.extend 'View', 'Alert.View', {

  mixinOptions:
    eventedMethods:
      render: {}

  initialize: ->
    @on 'render:before', -> alert 'Alert.View::render started'
    @on 'render:after', -> alert 'Alert.View::render completed'

}, mixins: [
  'EventedMethod.Mixin'
]

view = Oraculum.get 'Alert.View'
view.render()
```

This even works with targeting methods provided by other mixins, provided those mixins are injected before `EventedMethod.Mixin`.

#### Example: Hooking mixin methods
-----------------------------------
```coffeescript
Oraculum.defineMixin 'Some.Mixin',
  someMethod: -> alert 'Some Method'

Oraculum.extend 'View', 'Some.View', {

  mixinOptions:
    eventedMethods:
      someMethod: {}

  initialize: ->
    @on 'someMethod:before', -> alert 'Some.View::someMethod started'
    @on 'someMethod:after', -> alert 'Some.View::someMethod completed'

}, mixins: [
  'Some.Mixin'
  'EventedMethod.Mixin'
]

view = Oraculum.get 'Some.View'
view.someMethod()
```

And just in case you weren't sold yet, you can even hook methods of other mixins from within a mixin.

#### Example: Hooking mixin dependency methods
----------------------------------------------
```coffeescript
Oraculum.defineMixin 'SomeOther.Mixin', {

  mixinOptions:
    eventedMethods:
      someMethod: {}

  mixinitialize: ->
    @on 'someMethod:before', -> alert 'SomeOther.Mixin::someMethod started'
    @on 'someMethod:after', -> alert 'SomeOther.Mixin::someMethod completed'

}, mixins: [
  'Some.Mixin'
  'EventedMethod.Mixin'
]

Oraculum.extend 'View', 'SomeOther.View', {}, mixins: [
  'SomeOther.Mixin'
]

view = Oraculum.get 'SomeOther.View'
view.someMethod()
```

Importance of Mixin Order
-------------------------
-------------------------

As you can see from the above examples, the order in which you specify your mixins is important. In the `Hooking mixin methods` example we are careful to mixin `Some.Mixin` _before_ `EventedMethod.Mixin` so that when `EventedMethod.Mixin` gets initialize, all of `Some.Mixin`'s methods are available to target. Failing to consider the order of your mixins, or failing to include a mixin, are the most common type of error you are likely to encounter when developing applications in Oraculum. These errors can be easily fixed by reordering your mixins, or simply adding the missing mixin. As you continue to work with Oraculum, you will discover that the vast majority of "bugs" discovered in your application will be logicless misconfiguration, and can be fixed with one or two lines.
