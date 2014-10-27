Crucible.TestsController = Ember.ArrayController.extend
  itemController: 'test'
  actions:
    getConformance: ->
      results = $.ajax(
        url: "/tests/conformance"
        type: "GET"
        data: {'url' : $('input[name="test-url"]').val()}
      ).then( (response) =>
        console.log response
        conformance = response.results.text.div
        @set('conformance', conformance.replace('<table class="grid">','<table class="table table-bordered table-condensed">'))
      )

Crucible.TestController = Ember.ObjectController.extend
  needs: ['tests']
  actions:
    execute: (title, resourceClass) ->
      results = $.ajax(
        url: "/tests/execute/#{title}"
        type: "GET"
        data:
          'url': $('input[name="test-url"]').val()
          'resource_class': resourceClass
      ).then( (response) =>
        console.log response
        tests = []
        for test in @get('tests')
          # tests.push JSON.stringify(response.results[test])
          result = response.results[test]
          result['test_method'] = test
          tests.push result
        @set('results', tests)
      )

  panelStatus: ->
      switch @status
        when 'passed' then 'success'
        when 'failed' then 'danger'
        else 'warning'
