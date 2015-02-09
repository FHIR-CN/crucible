Crucible.DefaultRoute = Ember.Route.extend
  enter: (router) ->
    $('.login-alert').delay(4200).fadeTo(800,0)

  actions:
    loading: ->
      return if @routeName in ['servers.results', 'multiservers.results']
      loading = $('#loading-modal').modal(
        backdrop: 'static',
        keyboard: false
      )
      this.router.one('didTransition', ->
        loading.modal('hide')
      )
