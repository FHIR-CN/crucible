Crucible.TestsRoute = Ember.Route.extend
  model: ->
    @get('store').find('test')
