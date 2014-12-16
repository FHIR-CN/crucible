# For more information see: http://emberjs.com/guides/routing/

Crucible.Router.map ()->
  @resource('tests')
  @resource 'servers', ->
    @route 'new'
    @route 'show', path: ':server_id'
    @route 'results', path: ':server_id/results'
