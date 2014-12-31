Crucible.MultiserversRoute = Crucible.DefaultRoute.extend
  model: ->
    @store.findAll('multiserver')

Crucible.MultiserversShowRoute = Ember.Route.extend
  model: (params) ->
    @store.find('multiserver', params.multiserver_id)
  afterModel: (server) ->
  #   server.set("tests", @store.findAll("test"))
    conformance1 = DS.PromiseObject.create({promise: $.get("/api/servers/conformance?url=#{server.get("url1")}")})
    conformance1.then(() -> server.set("conformance1", conformance1.content))
    conformance2 = DS.PromiseObject.create({promise: $.get("/api/servers/conformance?url=#{server.get("url2")}")})
    conformance2.then(() -> server.set("conformance2", conformance2.content))

  # actions:
  #   executeTests:->
  #     @transitionTo('servers.results', @currentModel)

