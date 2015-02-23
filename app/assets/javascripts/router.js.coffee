# For more information see: http://emberjs.com/guides/routing/

Crucible.Router.map ()->
  @resource('tests')
  @resource 'servers', ->
    @route 'new'
    @route 'show', path: ':server_id', ->
      @resource 'runs', ->
        @route 'show', path: ':run_id'
    # @route 'results', path: ':server_id/results', ->

  @resource 'multiservers', ->
    @route 'show', path: ':multiserver_id'
    @route 'results', path: ':multiserver_id/results'
    
