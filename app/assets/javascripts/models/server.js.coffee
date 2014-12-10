Crucible.Server = DS.Model.extend
  url: DS.attr("string")
  conformance: DS.attr()
  tests: DS.attr()
  activeTestCount: (-> @get('tests').filterBy('active', true).getEach('tests').getEach('length').reduce(((s,t) -> s + t),0)).property('tests.@each.active')
  completedTestCount: (-> @get('tests').filterBy('completed', true).filterBy('active', true).getEach('tests').getEach('length').reduce(((s,t) -> s + t),0)).property('tests.@each.active', 'tests.@each.completed')
  executionProgress: (-> parseInt( @get('completedTestCount') / Math.max(@get('activeTestCount'),1) * 100) ).property('activeTestCount', 'completedTestCount')
  isComplete: (-> @get('tests').filterBy('running', true).length != 0).property('tests.@each.running')
  progressStyle: (-> if @get('executionProgress') < 2 then "width: 2%;" else "width: #{@get('executionProgress')}%;").property('executionProgress')
