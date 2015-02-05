Crucible.IndexController = Ember.ObjectController.extend
  multiServer: false

  actions:
    addUrl: ->
      this.set('multiServer', true)
    removeUrl: ->
      this.set('multiServer', false)
      @model.server2 = null
