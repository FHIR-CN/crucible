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

Crucible.MultiserversResultsRoute = Ember.Route.extend
    model: (params) ->
      @store.find('multiserver', params.multiserver_id)
    afterModel: (server) ->
      tests = server.get("tests.content.content")||[]
      if tests.length == 0
        @transitionTo('multiservers.show', server)
      for test in tests
        test.set("results", null)
        if test.get("active")# and not test.get("results")
          @execute(test, server)

    execute: (test, server) ->
      test.set("running", true)
      params = {}
      params.url1 = server.get("url1")
      params.url2 = server.get("url2")
      if test.get('resource_class')
        params.resource_class = test.get('resource_class')
      paramsString = Object.keys(params).map((k) -> (k+"="+params[k])).join("&")
      suitePromise = DS.PromiseObject.create({promise: $.get("/tests/execute/#{test.get("title")}?#{paramsString}")})
      suitePromise.then(() ->
        test.set("running", false)
        res= []
        title = test.get('title')
        title += "_#{test.get('resource_class').split('::')[1]}" if test.get('resource_class')?
        for testResult in suitePromise.content.results
          res.push(testResult[title])
        test.set("results", res)
      )
    actions:
      rerun: ->
        @transitionTo('multiservers.show', @currentModel)
