requirejs.config({
  baseUrl: './',

  paths: {
    // RequireJS plugins
    'cs': 'examples/vendor/require-cs-0.4.4',
    'text': 'examples/vendor/require-text-2.0.12',
    'coffee-script': 'examples/vendor/coffee-script-1.7.1.min',

    // FactoryJS
    'Factory': 'examples/vendor/Factory-1.0.0.min',
    'BackboneFactory': 'examples/vendor/BackboneFactory-1.0.0.min',

    // Util libs
    'marked': 'examples/vendor/marked-0.3.2.min',
    'jquery': 'examples/vendor/jquery-2.1.1.min',
    'backbone': 'examples/vendor/backbone-1.1.2.min',
    'gist-embed': 'examples/vendor/gist-embed-1.8',
    'underscore': 'examples/vendor/underscore-1.6.0.min'
  },

  shim: {
    marked: { exports: 'marked' },
    jquery: { exports: 'jQuery' },
    underscore: { exports: '_' },
    backbone: {
      deps: ['jquery', 'underscore'],
      exports: 'Backbone'
    }
  },

  packages: [{
    name: 'oraculum',
    location: 'dist'
  }, {
    name: 'app',
    location: 'examples/coffee'
  }, {
    name: 'md',
    location: 'examples/markdown'
  }],

  callback: function () {
    require(['jquery'], function($) {
      $(function() {
        require(['cs!app/index'])
      });
    });
  }
});
