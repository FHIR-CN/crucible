Crucible.TestRun = DS.Model.extend
  server: DS.belongsTo('server')
  date: DS.attr("date")
  results: DS.hasMany("testResult")


Crucible.TestResult = DS.Model.extend
  
