Crucible.TestRun = DS.Model.extend
  server: DS.belongsTo('server')
  date: DS.attr()
  results: DS.hasMany("testResult", {embedded: 'always'})
  conformance: DS.attr()

Crucible.TestResult = DS.Model.extend
  test: DS.belongsTo('test')
  testRun: DS.belongsTo('testRun')
  attribute: DS.attr()


Crucible.TestRunSerializer = DS.ActiveModelSerializer.extend
  primaryKey: (type) ->
    return '_id'
  attrs:
    results: {embedded: 'always'}

  # extract: (store, type, payload, id, requestType) ->
  #   debugger
