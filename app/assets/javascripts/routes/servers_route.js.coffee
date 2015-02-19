Crucible.ServersRoute = Crucible.DefaultRoute.extend
  model: ->
    @store.findAll('server')

Crucible.ServersShowRoute = Ember.Route.extend
  model: (params) ->
    @store.find('server', params.server_id)
  afterModel: (server) ->
    server.set("unsortedTests", (@store.findAll("test", {multiserver: false})))
    # conformance = DS.PromiseObject.create({promise: $.get("/api/servers/conformance?url=#{server.get("url")}")})
    # conformance.then(() => server.set("conformance", @store.createRecord('conformance', json: [conformance.content])))
    #
    # tests = DS.PromiseObject.create({promise: $.get("/tests/")})
    # tests.then(() -> server.set("tests", tests.content))

  actions:
    executeTests:->
      tests = []
      for test in @currentModel.get('tests')
        if test.get('active')
          tests.push(@store.createRecord('testResult', {"test": test}))
      run = @store.createRecord('testRun')
      run.set('server', @currentModel)
      run.get('results').pushObjects(tests)
      # run.set('conformance', @currentModel.get('conformance'))
      run.set('date', Date.now())
      run.save()

      # @transitionTo('servers.results', @currentModel)
    selectAll: ->
      @currentModel.get("tests").setEach("active", true)
    selectNone: ->
      @currentModel.get("tests").setEach("active", false)


Crucible.ServersNewRoute = Ember.Route.extend
  actions:
    submit: ->
      server = @get('currentModel')
      server.save()
      @transitionTo('servers.show', server)
  model: ->
    @store.createRecord('server')

Crucible.ServersResultsRoute = Ember.Route.extend
    model: (params) ->
      @store.find('server', params.server_id)
    afterModel: (server) ->
      tests = server.get("tests")||[]
      if tests.length == 0
        @transitionTo('servers.show', server)
      for test in tests
        test.set("results", null)
        if test.get("active")# and not test.get("results")
          @execute(test, server)

    execute: (test, server) ->
      test.set("running", true)
      params = {}
      params.url = server.get("url")
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
        @transitionTo('servers.show', @currentModel)
