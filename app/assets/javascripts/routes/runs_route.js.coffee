Crucible.RunsIndexRoute = Crucible.DefaultRoute.extend
  model: ->
    @store.findAll("testRun")

Crucible.RunsShowRoute = Crucible.DefaultRoute.extend
  model: (params) ->
    @store.find("testRun", params.run_id)
