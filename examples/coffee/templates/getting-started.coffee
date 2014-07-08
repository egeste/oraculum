define [
  'text!md/getting-started/dependencies.md'
], (args...) ->

  template = '<div id="top"></div>\n\n'
  template += args.join '\n\n<div class="clearfix"></div>\n\n\n'
  return template
