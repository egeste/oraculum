Overview
========
--------

Oraculum is a [javascript MVC framework](http://todomvc.com/architecture-examples/oraculum/) and a collection of mixins for [Backbone](http://backbonejs.org/) `Model`s, `Collection`s and `View`s written for [FactoryJS](https://github.com/lookout/factoryjs/). It inherits all of its application structure, many behaviors, and is generally inspired by [Chaplin](http://chaplinjs.org/).

Though a large portion of Oraculum's behavior is inherited from Chaplin, Oraculum employs a signficiantly different strategy surrounding the issues of inheritance, structure, and coupling. Applications built with Oraculum take full advantage of the [aspect-oriented programming](http://en.wikipedia.org/wiki/Aspect-oriented_programming) and [composition](http://en.wikipedia.org/wiki/Composition_over_inheritance) paradigms offered by FactoryJS. The purpose of this project is to collect abstract, reusable behaviors into a framework that  can be used by anyone building complex applications with Backbone.

Part of the core value provided by Oraculum is its lack of implicit behavior. All non-essential behaviors are optional, and no non-essential behavior is implicit. This means that your objects only ever execute code paths relevant to their concerns and you should never have to alter an object's prototype to stub its implicit behaviors. Oraculum accomplishes this by hooking targeted methods of object instances in-memory and providing a consistent eventing interface to those hooks.

Objects and classes composed with Oraculum are often no more than a few lines simple configuration, yet through their mixins they can be perform incredibly complex tasks. There are mixins that emulate or implement every behavior Chaplin provides, plus many other behaviors unique to Oraculum. Because all behaviors are optional and formatted using the FactoryJS mixin syntax, it's incredibly easy to add custom behaviors or import behaviors authored by the open source community.

<div class="clearfix"></div>

Architecture
------------
------------

Oraculum is part MVC framework and part behavior library. As such, the architecture can be thought of as two separate sets of components. The MVC component of Oraculum is a set of definitions and mixins that emulate the behaviors of Chaplin, and from a high-level perspective, share Chaplin's MVC architecture. The behavior library component of Oraculum is a set of definitions and mixins that aims solve generic, common use case problems such as binding an element's text property to an attribute of a data model, or dynamically sorting a collection's models.

<div class="clearfix"></div>

### FactoryJS Composition
-------------------------

<a href="examples/images/FactoryJS%20Composition%20Architecture.jpg" class="thumbnail pull-right col-xs-12 col-sm-4 col-md-3 text-center" target="_blank">
  <img src="examples/images/FactoryJS%20Composition%20Architecture.jpg" alt="The FactoryJS Composition Architecture"/>
  <small>The FactoryJS Composition Architecture</small>
</a>

Unlike any of psuedo classical inheritance mechanisms provided by other javascript frameworks or transpilers, Oraculum uses FactoryJS to perform object composition. This adds a critical layer of flexibility allowing object definition, extension, and overriding without mutating underlying prototypes. This means that your application can be modified, extended, or otherwise altered without affecting other parts of the system or losing the original definition. This is incredibly useful for adding and removing functionality from an existing application, or simply modifying an application's behavior, without ever having to touch the application's underlying code.

Oraculum relies on this property of FactoryJS via BackboneFactory to provide an altered `Model`, `Collection`, and `View` definition that allows referencing factory definitions by name, without modifying Backbone's `Model`, `Collection`, or `View` prototypes. If you want to, you can continue to use all of Backbone's classes like you normally would alongside Oraculum definitions.

<div class="clearfix"></div>
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">
      Example: Referencing factory definitions by name.
    </h3>
  </div>
  <div class="panel-body">
    <code data-gist-id="e0351634c1fa3eb93163"></code>
  </div>
  <div class="panel-footer">
    To learn more about FactoryJS, check out the [Lookout Hackers blog.](http://hackers.lookout.com/2014/03/factoryjs/)
  </div>
</div>

<div class="clearfix"></div>

### Chaplin Application Lifecycle
---------------------------------

<a href="http://chaplinjs.org/images/chaplin-lifecycle.png" class="thumbnail pull-left col-xs-12 col-sm-4 col-md-3 text-center" target="_blank">
  <img src="http://chaplinjs.org/images/chaplin-lifecycle.png" alt="The Chaplin Application Lifecycle"/>
  <small>The Chaplin Application Lifecycle</small>
</a>

Oraculum does not use Chaplin's code directly. Instead, Oraculum re-implements many of the core behaviors that Chaplin provides as a reusable set of mixins. The application lifecycle is the same, but the structure of the objects in the is composed by a core set of completely decoupled behaviors.

<div class="clearfix"></div>

### Oraculum Core Component Architecture
----------------------------------------

<a href="examples/images/Oraculum%20Core%20Component%20Architecture.jpg" class="thumbnail pull-right col-xs-12 col-sm-4 col-md-3 text-center" target="_blank">
  <img src="examples/images/Oraculum%20Core%20Component%20Architecture.jpg" alt="Oraculum Core Component Architecture"/>
  <small>Oraculum Core Component Architecture</small>
</a>

The diagram reveals numerous shared behaviors between various modules of the core MVC component architecture. As you will discover using Oraculum, the core MVC components aren't the only implementations that benefit from this type of code reuse. Your `View`s, `Models`, `Collection`s, and other objects will benefit from being able to mix in these behaviors as well.

<div class="clearfix"></div>

How to get it
-------------
-------------

<div class="row">
  <div class="col-md-12 col-lg-6">
    <div class="panel panel-warning">
      <div class="panel-heading">
        <h3 class="panel-title">
          <img src="http://bower.io/favicon.ico"/>
          As a Bower component
        </h3>
      </div>
      <div class="panel-body">
        Within the directory of your existing git repo, run:
        <pre>bower install oraculum --save</pre>
      </div>
    </div>
  </div>

  <div class="col-md-12 col-lg-6">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title">
          <img src="https://github.com/favicon.ico"/>
          As a git repo
        </h3>
      </div>
      <div class="panel-body">
        Within the directory where you want to place the repo, run:
        <pre>git clone git@github.com:lookout/oraculum.git</pre>
      </div>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-md-12 col-lg-6">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title">
          <img src="https://github.com/favicon.ico"/>
          As a git submodule
        </h3>
      </div>
      <div class="panel-body">
        Within the desired directory of your existing git repo, run:
        <pre>git submodule add git@github.com:lookout/oraculum.git</pre>
      </div>
    </div>
  </div>
  <div class="col-md-12 col-lg-6">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title">
          <img src="https://github.com/favicon.ico"/>
          Download a zip or tarball
        </h3>
      </div>
      <div class="panel-body text-center">
        <a href="https://github.com/lookout/oraculum/releases/latest" class="btn btn-lg btn-success" target="_blank">
          <span class="glyphicon glyphicon-download"></span>
          Download from github
        </a>
      </div>
    </div>
  </div>
</div>
