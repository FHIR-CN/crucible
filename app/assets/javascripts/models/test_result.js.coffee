Crucible.TestResult = DS.Model.extend
  test: DS.belongsTo('test', {async: true})
  testRun: DS.belongsTo('testRun')
  result: DS.attr()#DS.belongsTo('result', {async: true})
  hasRun: DS.attr("boolean")

Crucible.TestResultSerializer = DS.ActiveModelSerializer.extend
  primaryKey: '_id'
