#= require jquery
#= require underscore
#= require jquery_ujs
#= require turbolinks
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require crucible
#= require_tree .
#= require bootstrap-sprockets

# for more details see: http://emberjs.com/guides/application/
window.Crucible = Ember.Application.create()


Ember.Application.initializer
  name: 'currentUser'

  initialize: (container) ->
    store = container.lookup('store:main')
    attributes = $('meta[name="current-user"]').attr('content')
    if attributes
      attributes = JSON.parse(attributes)
      attributes.id = attributes._id
      user = store.push('user', attributes)
      container.register('user:current', user, {singleton: true, instantiate:false})
      container.typeInjection('controller', 'currentUser', 'user:current')
