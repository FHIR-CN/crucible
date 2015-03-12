Crucible.ServersIndexRoute = Crucible.DefaultRoute.extend
  model: ->
    @store.findAll('server')

Crucible.ServersShowRoute = Ember.Route.extend
  model: (params) ->
    console.log "Test"
    Ember.RSVP.hash(
      server: @store.find('server', params.server_id)
      tests: @store.findAll("test")
    )
  afterModel: (model) ->
    conformance = DS.PromiseObject.create({promise: $.get("/api/servers/conformance?url=#{model.server.get("url")}")})
    conformance.then(() => model.server.set("conformance", @store.createRecord('conformance', json: [conformance.content])))

  actions:
    executeTests:->
      run = @store.createRecord('testRun', {'server': @currentModel.server})
      run.set('conformance', @currentModel.server.get('conformance'))
      run.get('testResults').pushObjects(@currentModel.tests.filterBy('selected').map((test) => @store.createRecord('testResult', {'test': test})))
      debugger
      run.save().then(=>
        run.get('testResults').filterBy('id', null).invoke('deleteRecord');
        @transitionTo('test_runs.show', run)
      )

Crucible.ServersNewRoute = Ember.Route.extend
  actions:
    submit: ->
      server = @get('currentModel')
      server.save()
      @transitionTo('servers.show', server)
  model: ->
    @store.createRecord('server')

# Use DefaultRoute and handle server.results to prevent Please Wait message
Crucible.ServersResultsRoute = Crucible.DefaultRoute.extend
    model: (params) ->
      @store.find('server', params.server_id)
    afterModel: (server) ->
      tests = server.get("tests")||[]
      @transitionTo('servers.show', server) if tests.length == 0
      test.set("results", null) for test in tests
      # Retain all active tests
      @executableTests = (test for test in tests when test.get('active'))
      # Execute the first test, which will execute subsequent tests, if any
      @execute(@executableTests.shift(), server) if @executableTests.length>0

    execute: (test, server) ->
      test.set("running", true)
      params = {}
      params.url = server.get("url")
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
        @transitionTo('servers.show', @currentModel)
