Crucible.Test = DS.Model.extend
  name: DS.attr('string')
  title: DS.attr('string')
  author: DS.attr('string')
  description: DS.attr('string')
  resource_class: DS.attr('string')
  methods: DS.attr()

Crucible.TestSerializer = DS.ActiveModelSerializer.extend
  primaryKey: '_id'
