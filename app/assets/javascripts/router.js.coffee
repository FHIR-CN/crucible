# For more information see: http://emberjs.com/guides/routing/

Crucible.Router.map ()->
  @resource('tests')
  @resource 'servers', ->
    @route 'new'
    @route 'servers'

  @resource 'server', path: 'server/:server_id'
  # @resource('application', path: '/')
