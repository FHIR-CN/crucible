Crucible.TestRun = DS.Model.extend
  server: DS.belongsTo('server')
  date: DS.attr()
  testResults: DS.hasMany("testResult")
  conformance: DS.attr()

Crucible.TestResult = DS.Model.extend
  test: DS.belongsTo('test')


Crucible.TestRunSerializer = DS.ActiveModelSerializer.extend
  primaryKey: (type) ->
    return '_id'
  attrs:
    results: {embedded: 'always'}

  serializeHasMany: (snapshot, json, relationship) ->
    json[relationship.key] = {}
    json[relationship.key] = []
    for result in snapshot.hasMany(relationship.key)
      json[relationship.key].push(result.record.toJSON())
      # ["#{Em.String.decamelize(Em.String.pluralize(relationship.type.typeKey))}"]
