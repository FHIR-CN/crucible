Crucible.DefaultRoute = Ember.Route.extend
  enter: (router) -> 
    $('.login-alert').delay(4200).fadeTo(800,0)

  actions:
    loading: ->
      x = $('#loading-modal').modal(
        backdrop: 'static',
        keyboard: false
      )
      this.router.one('didTransition', ->
        x.modal('hide')
      )
      

