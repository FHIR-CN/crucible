# For more information see: http://emberjs.com/guides/routing/

Crucible.Router.map ()->
  @resource('tests')
  @resource 'servers', ->
    @route 'new'
    @route 'show', path: ':server_id'
    @route 'results', path: ':server_id/results'
  @resource 'test_runs', ->
    @route 'show', path: ':test_run_id'
  @resource 'multiservers', ->
    @route 'show', path: ':multiserver_id'
