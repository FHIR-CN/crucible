# For more information see: http://emberjs.com/guides/routing/

Crucible.Router.map ()->
  @resource('tests')
  @resource 'servers', ->
    @route 'new'

  @resource 'server', path: 'server/:server_id'
  # @resource('application', path: '/')
