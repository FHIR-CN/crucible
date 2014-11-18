Crucible.ServersRoute = Ember.Route.extend
  model: ->
    @store.findAll('server')


Crucible.ServerRoute = Ember.Route.extend
  model: (params) ->
    @store.find('server', params.server_id)

Crucible.ServersNewRoute = Ember.Route.extend
  actions:
    submit: ->
      server = @get('currentModel')
      # If we're logged in, save it
      if @controller.get('currentUser')
        server = server.save()
      # Else generate a fake id so we can proceed using it. 
      else
        server.id = Em.generateGuid(server, 'server')
      @transitionTo('server', server)
  model: ->
    @store.createRecord('server')
