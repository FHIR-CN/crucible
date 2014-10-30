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
    goToLink: (item, anchor) ->
      $elem = $(anchor)
      $scrollTo = $('body').scrollTop($elem.offset().top)
      @transitionToRoute(item.route).then($scrollTo)
    goToTest: (test) ->
      @send('goToLink','tests', "##{test.resource_class?.split('::')?[1]||''}-#{test.test_method}")
    executeAll: ->
      @forEach (test) ->
        test.send('execute')

  hasResults: ( ->
    @filter((t) -> t.get('results')?.length)?.length > 0
  ).property('@each.results')

Crucible.TestController = Ember.ObjectController.extend
  needs: ['tests']
  actions:
    execute: ->
      results = $.ajax(
        url: "/tests/execute/#{@get('title')}"
        type: "GET"
        data:
          'url': $('input[name="test-url"]').val()
          'resource_class': @get('resource_class')
      ).then( (response) =>
        console.log response
        tests = []
        for test in @get('tests')
          result = response.results[test]
          result['test_method'] = test
          result['resource_class'] = @get('resource_class') if @get('resource_class')
          tests.push result
        @set('results', tests)
      )

  panelStatus: ->
    switch @status
      when 'passed' then 'success'
      when 'failed' then 'danger'
      else 'warning'

  iconStatus: ->
    switch @status
      when 'passed' then 'fa-check-circle-o text-success'
      when 'failed' then 'fa-times-circle-o text-danger'
      else 'fa-circle-o text-warning'

  panelAnchor: -> "#{@resource_class?.split('::')?[1]||''}-#{@test_method}"

  resultSummary: ( ->
    summary =
      name: @get('resource_class') || @get('title')
      results: ( (_.filter(@get('results'), (r) => r.test_method == t))?[0] for t in @get('tests') )
  ).property('results')

  hasResult: ( ->
    @get('results')?.length
  ).property('results')
