Crucible.UsersIndexRoute = Crucible.DefaultRoute.extend

  model: ->
    Ember.RSVP.hash(
      servers: @store.findAll('server')
      testRuns:  @store.findAll('testRun')
      currentServer: null
    )

  actions:
    serverSelect: (selection) ->
      @currentModel.currentServer = selection

    submit: ->
      server = @store.createRecord('server', url: @currentModel.url);
      server.save()
      $('#addServerInput').hide()

    addServer: ->
    	$('#addServerInput').show()