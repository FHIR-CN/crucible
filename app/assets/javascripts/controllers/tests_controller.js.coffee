Crucible.TestsController = Ember.ArrayController.extend
  itemController: 'test'

Crucible.TestController = Ember.ObjectController.extend
  needs: ['tests']
  actions:
    execute: (title) ->
      results = $.ajax(
        url: "/tests/execute/#{title}",
        type: "GET"
        data: {'url' : $('input[name="test-url"]').val()}
      ).then( (response) =>
        console.log response
        console.log @get('tests')
        tests = []
        for test in @get('tests')
          tests.push JSON.stringify(response.results[test])
        @set('results', tests)
      )
