Crucible.MultiserversRoute = Crucible.DefaultRoute.extend
  model: ->
    @store.findAll('multiserver')

Crucible.MultiserversShowRoute = Ember.Route.extend
  model: (params) ->
    @store.find('multiserver', params.multiserver_id)
  afterModel: (server) ->
    server.set("tests", @store.find("test", {multiserver: true}))

    conformance1 = DS.PromiseObject.create({promise: $.get("/api/servers/conformance?url=#{server.get("url1")}")})
    conformance1.then(() -> server.set("conformance1", conformance1.content))
    conformance2 = DS.PromiseObject.create({promise: $.get("/api/servers/conformance?url=#{server.get("url2")}")})
    conformance2.then(() -> server.set("conformance2", conformance2.content))

  actions:
    executeTests:->
      @transitionTo('multiservers.results', @currentModel)

# Use DefaultRoute and handle server.results to prevent Please Wait message
Crucible.MultiserversResultsRoute = Crucible.DefaultRoute.extend
    model: (params) ->
      @store.find('multiserver', params.multiserver_id)
    afterModel: (server) ->
      tests = server.get("tests.content.content")||[]
      @transitionTo('multiservers.show', server) if tests.length == 0
      test.set("results", null) for test in tests
      # Retain all active tests
      @executableTests = (test for test in tests when test.get('active'))
      # Execute the first test, which will execute subsequent tests, if any
      @execute(@executableTests.shift(), server) if @executableTests.length>0

    execute: (test, server) ->
      test.set("running", true)
      params = {}
      params.url1 = server.get("url1")
      params.url2 = server.get("url2")
      if test.get('resource_class')
        params.resource_class = test.get('resource_class')
      paramsString = Object.keys(params).map((k) -> (k+"="+params[k])).join("&")
      suitePromise = DS.PromiseObject.create({promise: $.get("/tests/execute/#{test.get("title")}?#{paramsString}")})
      suitePromise.then(() =>
        test.set("running", false)
        res= []
        title = test.get('title')
        title += "_#{test.get('resource_class').split('::')[1]}" if test.get('resource_class')?
        for testResult in suitePromise.content.results
          res.push(testResult[title])
        test.set("results", res)
        @execute(@executableTests.shift(), server) if @executableTests.length>0
      )
    actions:
      rerun: ->
        @transitionTo('multiservers.show', @currentModel)
