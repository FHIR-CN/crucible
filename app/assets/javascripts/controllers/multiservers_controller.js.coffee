Crucible.MultiserversShowController = Ember.ObjectController.extend
  actions:
    multiserverSelect: ->
      selected = $('#multiserver-selector').val()
      $('#resource-chart .test-filled, .test-empty, .left-circle, .right-circle').css('visibility', 'hidden')
      switch selected
        when "Server 1 AND Server 2" then $('#resource-chart .test-filled').css('visibility', 'visible') 
        when "Server 1 OR Server 2" then $('#resource-chart .test-filled, .test-empty, .left-circle, .right-circle').css('visibility', 'visible')
        when "Server 1 - EXCLUSIVE" then $('#resource-chart .left-circle').css('visibility', 'visible')
        when "Server 2 - EXCLUSIVE" then $('#resource-chart .right-circle').css('visibility', 'visible')
        else console.log 'Please check selector'