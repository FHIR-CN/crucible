Crucible.TestResult = DS.Model.extend
  test: DS.belongsTo('test', {async: true})
  testRun: DS.belongsTo('testRun')
  result: DS.belongsTo('result', {async: true})
  hasRun: DS.attr("boolean")

Crucible.Result = DS.Model.extend
  result: DS.attr()

Crucible.TestResultSerializer = DS.ActiveModelSerializer.extend
  primaryKey: '_id'
  normalize: (type, hash, prop) ->
    delete hash.result # Even if populated I want to force an ajax call
    hash.links = {result: "result"}
    @_super(type,hash,prop)
