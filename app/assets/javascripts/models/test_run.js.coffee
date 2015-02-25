Crucible.TestRun = DS.Model.extend
  testResults: DS.hasMany('testResult')
  conformance: DS.attr()
  date: DS.attr("date")
  server: DS.belongsTo("server", {async: true})

Crucible.TestRunSerialzier = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    testResults: {embedded:'always'}
