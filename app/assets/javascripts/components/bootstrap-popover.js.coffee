Crucible.BootstrapPopoverComponent = Ember.Component.extend
  tagName: 'div'
  classNames: 'conformance-badge-popover'
  placement: 'top'
  didInsertElement: ->
    component  = @
    contents = @$('.popover-js')
    component.$().popover(
      trigger: 'hover'
      animation: false
      placement: component.get('placement')
      html: true
      content: contents
    ).on('show.bs.popover', ->
      contents.removeClass('hide')
    )
  willDestroyElement: -> @$().popover('destroy')
