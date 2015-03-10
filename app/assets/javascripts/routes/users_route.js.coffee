Crucible.UsersIndexRoute = Crucible.DefaultRoute.extend
  model: ->
    Ember.RSVP.hash(
      servers: @store.findAll('server')
      testRuns: @store.findAll('testRun')
      tests: @store.findAll('test')      
    )

  actions: 
    submit: ->
      server = @store.createRecord('server', url: @currentModel.url);
      server.save()
      $('#addServerInput').hide()

    addServer: ->
      $('#addServerInput').toggle()

    runTest: (server) ->
      @transitionTo('servers.show', server)
