Crucible.IndexRoute = Em.Route.extend
  actions:
    submit: ->
      server = @get('currentModel')
      server.save()
      @transitionTo('server', server)
  model: ->
    @store.createRecord('server')
