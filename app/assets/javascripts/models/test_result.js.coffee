Crucible.TestResult = DS.Model.extend
  test: DS.belongsTo('test')
  testRun: DS.belongsTo('testRun')
  result: DS.attr()#DS.belongsTo('result', {async: true})
  hasRun: DS.attr("boolean")

Crucible.TestResultSerializer = DS.ActiveModelSerializer.extend
  primaryKey: '_id'

  normalize: (type, hash, prop)->
    debugger
    hash.links = {result: "/api/tests/#{hash._id}/#{hash.server_id}?resource_class=#{hash.resouce_class||''}"}
    @_super(type, hash, prop)
