Crucible.IndexRoute = Em.Route.extend
  actions:
    submit: ->
      server = @get('currentModel')
      server.save()
      @transitionTo('servers.show', server)
  model: ->
    @store.createRecord('server')
