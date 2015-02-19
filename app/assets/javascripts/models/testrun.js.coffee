Crucible.TestRun = DS.Model.extend
  server: DS.belongsTo('server')
  date: DS.attr()
  results: DS.hasMany("testResult")
  conformance: DS.attr()

Crucible.TestResult = DS.Model.extend
  test: DS.belongsTo('test')


Crucible.TestRunSerializer = DS.RESTSerializer.extend
  primaryKey: (type) ->
    return '_id'
  attrs:
    results: {embedded: 'always'}

  serializeHasMany: (snapshot, json, relationship) ->
    json[relationship.key] = {}
    json[relationship.key]["#{Em.String.pluralize(relationship.type.typeKey)}"] = []
    for result in snapshot.hasMany(relationship.key)
      json[relationship.key]["#{Em.String.pluralize(relationship.type.typeKey)}"].push(result.record.toJSON())
