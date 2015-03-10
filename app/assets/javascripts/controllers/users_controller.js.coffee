Crucible.UsersIndexController = Ember.ObjectController.extend

  servers: Ember.computed.oneWay('model.servers')
  proxiedServers: Ember.computed.map('servers', (server) -> Ember.Object.create(content: server, selected: false))
  currentServers: (->
    @get('proxiedServers').filterBy('selected', true).mapBy('content')
  ).property('proxiedServers.@each.selected')

  actions:
    toggleServer: (server) ->
      server.toggleProperty('selected')
      false