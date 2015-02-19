Crucible.UsersIndexController = Ember.ObjectController.extend

  actions:

    click: (selection) ->
      $tab = '#' + selection
      $content = $tab + "-content"

      $('#tab-1').removeClass('active')
      $('#tab-2').removeClass('active')
      $('#tab-3').removeClass('active')
      $('#tab-4').removeClass('active')

      $('#tab-1-content').hide()
      $('#tab-2-content').hide()
      $('#tab-3-content').hide()
      $('#tab-4-content').hide()

      $($tab).addClass('active')
      $($content).show()