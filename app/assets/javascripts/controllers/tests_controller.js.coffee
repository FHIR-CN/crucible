Crucible.TestsController = Ember.ArrayController.extend
  itemController: 'test'

Crucible.TestController = Ember.ObjectController.extend
  needs: ['tests']
  actions:
    execute: (title) ->
      results = $.ajax(
        url: "/tests/execute/#{title}",
        type: "GET"
      ).then( (response) =>
        tests = []
        for test in @get('tests')
          tests.push "#{response.results[test].test_method}: #{response.results[test].status}. #{response.results[test].result}"
        @set('tests', tests)
      )
