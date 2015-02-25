Crucible.TestRun = DS.Model.extend
  testResults: DS.hasMany('testResult')
  conformance: DS.attr()
  date: DS.attr("date")
  server: DS.belongsTo("server", {async: true})

Crucible.TestRunSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  primaryKey: '_id'
  attrs:
    testResults: {embedded:'always'}
  # serializer: (snapshot, options) ->
  #   debugger
  # serializeHasMany: (snapshot, json, relationship) ->
  #   debugger
  #   json[relationship.key] = {}
  #   json[relationship.key] = []
  #   for result in snapshot.hasMany(relationship.key)
  #     json[relationship.key].push(result.record.toJSON())
  # normalize: (type, hash, prop)->
  #   debugger
  extract: (store, type, payload, id, requestType)  ->
    payload.test_results = {test_results: payload.test_results}
    console.log payload
    @_super(store, type, payload, id, requestType)
