Crucible.ServersRoute = Ember.Route.extend
  model: ->
    @store.findAll('server')


Crucible.ServerRoute = Ember.Route.extend
  model: (params) ->
    @store.find('server', params.server_id)
  afterModel: (server) ->
    server.set("tests", @store.findAll("test"))
    conformance = DS.PromiseObject.create({promise: $.get("/tests/conformance?url=#{server.get("url")}")})
    conformance.then(() -> server.set("conformance", conformance.content.results))
    #
    # tests = DS.PromiseObject.create({promise: $.get("/tests/")})
    # tests.then(() -> server.set("tests", tests.content))
  execute: (test) ->
    test.set("running", true)
    params = {}
    params.url = @currentModel.get("url")
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
    executeTests:->
      tests = @currentModel.get("tests.content.content")
      for test in tests
        if test.get("active") and not test.get("results")
          @execute(test)


Crucible.ServersNewRoute = Ember.Route.extend
  actions:
    submit: ->
      server = @get('currentModel')
      # We have to generate a fake ID for the server so we can route to it
      server.id = Em.generateGuid(server, 'server')
      @transitionTo('server', server)
  model: ->
    @store.createRecord('server')
