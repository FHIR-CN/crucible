Crucible.TestRun = DS.Model.extend
  testResults: DS.hasMany('testResult')
  conformance: DS.attr()
  date: DS.attr("date")
  server: DS.belongsTo("server", {async: true})

Crucible.TestRunSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  primaryKey: '_id'
  attrs:
    testResults: {embedded:'always'}
