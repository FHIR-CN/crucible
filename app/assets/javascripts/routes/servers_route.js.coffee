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
      # We have to generate a fake ID for the server so we can route to it
      server.id = Em.generateGuid(server, 'server')
      @transitionTo('server', server)
  model: ->
    @store.createRecord('server')
