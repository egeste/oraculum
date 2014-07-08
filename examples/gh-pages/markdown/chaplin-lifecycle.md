<!--
Chaplin Application Architecture
  Short overview
  What is different
-->

Chaplin Application Lifecycle
-----------------------------
-----------------------------

<a href="http://chaplinjs.org/images/chaplin-lifecycle.png" class="thumbnail pull-left col-xs-12 col-sm-4 col-md-3 text-center" target="_blank">
  <img src="http://chaplinjs.org/images/chaplin-lifecycle.png" alt="The Chaplin Application Lifecycle"/>
  <small>The Chaplin Application Lifecycle</small>
</a>

Oraculum does not use Chaplin's code directly. Instead, Oraculum re-implements many of the core behaviors that Chaplin provides as a reusable set of mixins. The application lifecycle is the same, but the structure of the objects in the is composed by a core set of completely decoupled behaviors.
