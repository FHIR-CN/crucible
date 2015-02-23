Crucible.TestRun = DS.Model.extend
  server: DS.belongsTo('server')
  date: DS.attr()
  tests: DS.hasMany("test")
  conformance: DS.attr()



Crucible.TestRunSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  primaryKey: '_id'
  attrs:
    tests: {embedded: 'always'}

  serializeHasMany: (snapshot, json, relationship) ->
    json[relationship.key] = {}
    json[relationship.key] = []
    for result in snapshot.hasMany(relationship.key)
      json[relationship.key].push(result.record.toJSON())
      # ["#{Em.String.decamelize(Em.String.pluralize(relationship.type.typeKey))}"]
