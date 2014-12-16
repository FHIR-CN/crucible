Crucible.IndexRoute = Em.Route.extend
  actions:
    submit: ->
      server = @get('currentModel')
      server.save()
      @transitionTo('servers', server)
  model: ->
    @store.createRecord('server')
