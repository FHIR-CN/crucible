Crucible.UsersIndexRoute = Crucible.DefaultRoute.extend

  model: ->
    Ember.RSVP.hash(
      servers: @store.findAll('server')
      currentServer: null
      testRuns: @store.findAll('test_run')
    )

  actions:
    serverSelect: (selection) ->
      @currentModel.currentServer = selection
      this.model.reload()

    submit: ->
      server = @store.createRecord('server', url: @currentModel.url);
      server.save()
      $('#addServerInput').hide()
      
    addServer: ->
    	$('#addServerInput').show()