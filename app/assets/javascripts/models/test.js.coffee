Crucible.Test = DS.Model.extend
  title: DS.attr('string')
  author: DS.attr('string')
  description: DS.attr('string')
  resource_class: DS.attr('string')
  tests: DS.attr()
  results: DS.attr()
