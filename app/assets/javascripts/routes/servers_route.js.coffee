Crucible.ServersRoute = Crucible.DefaultRoute.extend
  model: ->
    @store.findAll('server')


Crucible.ServersShowRoute = Ember.Route.extend
  model: (params) ->
    @store.find('server', params.server_id)
  afterModel: (server) ->
    server.set("tests", @store.findAll("test"))

    conformance = DS.PromiseObject.create({promise: $.get("/api/servers/conformance?url=#{server.get("url")}")})
    conformance.then(() => server.set("conformance", @store.createRecord('conformance', json: [conformance.content])))
    #
    # tests = DS.PromiseObject.create({promise: $.get("/tests/")})
    # tests.then(() -> server.set("tests", tests.content))

  actions:
    executeTests:->
      debugger
      # @transitionTo('servers.results', @currentModel)


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
      # server.set("tests", @store.findAll("test"))
      # conformance = DS.PromiseObject.create({promise: $.get("/api/servers/conformance?url=#{server.get("url")}")})
      # conformance.then(() -> server.set("conformance", conformance.content))
      tests = server.get("tests.content.content")||[]
      if tests.length == 0
        @transitionTo('servers.show', server)
      for test in tests
        test.set("results", null)
        if test.get("active")# and not test.get("results")
          @execute(test, server)

      #
      # tests = DS.PromiseObject.create({promise: $.get("/tests/")})
      # tests.then(() -> server.set("tests", tests.content))
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
