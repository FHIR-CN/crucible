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
  summary: (->
    summary = {}
    if @get('completed')
      for suite in @get('results')
        for test in suite.tests
          if test.validates?
            for validation in test.validates
              res = validation.resource || 'system'
              summary[res] ?= {}
              for method in validation.methods
                summary[res][method] ?= {status: "", passed: [], failed: [], skipped: []}
                switch test.status
                  when 'pass' then summary[res][method].passed.push(test.key)
                  when 'fail' then summary[res][method].failed.push(test.key)
                  when 'skip' then summary[res][method].skipped.push(test.key)
                  else {}
                summary[res][method]['status'] = 'results-failed' if summary[res][method].failed.length
                summary[res][method]['status'] = 'results-passed' if summary[res][method].passed.length && !summary[res][method].failed.length
    summary
  ).property('results')
