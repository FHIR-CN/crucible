Crucible.UsersIndexRoute = Crucible.DefaultRoute.extend
  model: ->
    Ember.RSVP.hash(
      servers: @store.findAll('server')
      currentServer: null
    )

  actions:
    serverSelect: (selection) ->
      currentServer = selection

    submit: ->
      server = @get('currentModel')
      @store.createRecord('server')
      $('#addServerInput').hide()
      $('#serverList').append('<p {{action \'serverSelect\'' + server + '}}>' + server.url + '</p>')

    addServer: ->
    	$('#addServerInput').show()
