Crucible.UsersIndexRoute = Crucible.DefaultRoute.extend

  model: ->
    Ember.RSVP.hash(
      servers: @store.findAll('server')
      testRuns:  @store.findAll('testRun')
      tests: @store.findAll('test')
      currentServer: null
    )

  actions:
    serverSelect: (selection) ->
      console.log selection.get('url')
      Ember.set(@currentModel, 'currentServer', selection)#Em.RSVP.hash(server: selection, tests: this.currentModel.tests))

    submit: ->
      server = @store.createRecord('server', url: @currentModel.url);
      server.save()
      $('#addServerInput').hide()

    runTest: (server) ->
      @transitionTo('servers.show', server)

    addServer: ->
      $('#addServerInput').toggle()
