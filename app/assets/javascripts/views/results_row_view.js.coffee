Crucible.ResultsRowView = Ember.View.extend
  tagName: 'tr'
  attributeBindings: ['href', 'data-toggle']
  href: "#test_result"
  'data-toggle': 'pill'

  # FIXME Replace call to templateData with proper accessor to test attributes
  setHref: (-> @set('href', "#test_result#{@templateData.keywords.test.id}")).on('init')

  click: (e) ->
    @$(e.target).closest('tbody').children('tr').removeClass('active')
    @$(e.target).closest('tr').addClass('active')
