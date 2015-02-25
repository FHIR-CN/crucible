Crucible.TestResult = DS.Model.extend
  test: DS.belongsTo('test', {async: true})
  testRun: DS.belongsTo('testRun')
  result: DS.attr()
  hasRun: DS.attr("boolean")
