Crucible.TestsRoute = Crucible.DefaultRoute.extend
  model: ->
    @get('store').find('test')
