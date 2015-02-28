Crucible.UsersIndexRoute = Crucible.DefaultRoute.extend
  model: ->
    Ember.RSVP.hash(
      servers: @store.findAll('server')
      currentServer: @store.find('server', '54ee16ca4d4d325d5e040000')
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
