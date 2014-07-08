define [
  'text!README.md'
  'text!md/overview/architecture.md'
  'text!md/overview/factoryjs-composition.md'
  'text!md/overview/chaplin-lifecycle.md'
  'text!md/overview/oraculum-core.md'
  'text!md/overview/how-to-get-it.md'
], (args...) ->

  template = '<div id="top"></div>\n\n'
  template += args.join '\n\n<div class="clearfix"></div>\n\n\n'
  return template
