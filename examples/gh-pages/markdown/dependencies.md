Dependencies
------------
------------

<div class="text-center alert alert-info" role="alert">
  <strong>
    Heads up!
  </strong>
  To make Oraculum available in other environments, we plan to convert it to [CommonJS](http://wiki.commonjs.org/wiki/CommonJS) and provide a [UMD](https://github.com/umdjs/umd) build.
  <br/>
  <br/>
  <a href="https://github.com/lookout/oraculum/issues?milestone=1&state=open" class="btn btn-primary">
    We would love your help!
  </a>
</div>

Oraculum is a superset of Backbone and FactoryJS. To get an Oraculum application off the ground we first need load these libraries and their dependencies. Feel free to use the AMD library of your choice, but the following examples will assume you're using RequireJS. For the sake of brevity, these examples will also assume your project root is '.' and you're using bower for dependency management.

#### Sample bower.json
----------------------
```json
{
  "name": "my_awesome_app",
  "version": "0.0.0",
  "description": "This app is so awesome it will blow your mind",
  "dependencies": {
    "oraculum": "latest"
  }
}
```

Oraculum's only dependency is on FactoryJS, which in turn depends on Backbone, Underscore and jQuery. Feel free to take a peek at [Oraculum's bower.json](https://github.com/lookout/oraculum/blob/master/bower.json).

Now that we have all of our dependencies, we need to tell our module loader how to find them.

#### Sample RequireJS Configuration
-----------------------------------
```coffeescript
require.config({
  basePath: 'js/'
  paths:
    jquery: 'bower_components/jquery/dist/jquery'
    backbone: 'bower_components/backbone/backbone'
    underscore: 'bower_components/underscore/underscore'
    Factory: 'bower_components/factoryjs/dist/Factory'
    BackboneFactory: 'bower_components/factoryjs/dist/BackboneFactory'
  packages: [{
    name: 'oraculum'
    location: 'bower_components/oraculum/dist'
  }, {
    name: 'MyApp'
    location: 'app'
  }]
})
```

You may notice a couple interesting things about this config. First, BackboneFactory - what is that? BackboneFactory is a FactoryJS container for Backbone objects provided by FactoryJS. Oraculum mirrors the definitions of BackboneFactory which is how it resolves things like `collection: 'Collection'`.

<!--
Getting Started
  RequireJS and dependencies
  MakeEventedMethod, AOP hooks
  Importance of mixin order
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
