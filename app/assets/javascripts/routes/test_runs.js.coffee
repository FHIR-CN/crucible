Crucible.TestRunsShowRoute = Crucible.DefaultRoute.extend
  beforeModel: (transition)->
    @store.findAll('test')
