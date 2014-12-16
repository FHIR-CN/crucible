Crucible.Test = DS.Model.extend
  title: DS.attr('string')
  author: DS.attr('string')
  description: DS.attr('string')
  resource_class: DS.attr('string')
  tests: DS.attr()
  results: DS.attr()
  running: DS.attr("boolean", defaultValue: false)
  active:  DS.attr("boolean", defaultValue: false) # Change me to True to default to run all tests
  reference: (-> @get('id').replace("::", "_")).property("id")
  completed: (-> @get('results')?).property("results")
  passed: ( ->
    if @get('completed')
      !@get('results').any((test) ->
        test.tests.any((result) ->
          result.status == "fail" or result.status == "error"
        )
      )
    else
      false
  ).property('results')
