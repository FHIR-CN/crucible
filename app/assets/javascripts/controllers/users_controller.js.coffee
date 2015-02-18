Crucible.UsersIndexController = Ember.ObjectController.extend

  actions:

  	click: (content) ->
  	


    click1: ->

      $('#tab-1').removeClass('active')
      $('#tab-2').removeClass('active')
      $('#tab-3').removeClass('active')
      $('#tab-4').removeClass('active')

      $('#tab-1-content').hide()
      $('#tab-2-content').hide()
      $('#tab-3-content').hide()
      $('#tab-4-content').hide()

      $('#tab-1').addClass('active')
      $('#tab-1-content').show()

   click2: ->

      $('#tab-1').removeClass('active')
      $('#tab-2').removeClass('active')
      $('#tab-3').removeClass('active')
      $('#tab-4').removeClass('active')

      $('#tab-1-content').hide()
      $('#tab-2-content').hide()
      $('#tab-3-content').hide()
      $('#tab-4-content').hide()

      $('#tab-2').addClass('active')
      $('#tab-2-content').show()

   click3: ->

      $('#tab-1').removeClass('active')
      $('#tab-2').removeClass('active')
      $('#tab-3').removeClass('active')
      $('#tab-4').removeClass('active')

      $('#tab-1-content').hide()
      $('#tab-2-content').hide()
      $('#tab-3-content').hide()
      $('#tab-4-content').hide()

      $('#tab-3').addClass('active')
      $('#tab-3-content').show()

   click4: ->

      $('#tab-1').removeClass('active')
      $('#tab-2').removeClass('active')
      $('#tab-3').removeClass('active')
      $('#tab-4').removeClass('active')

      $('#tab-1-content').hide()
      $('#tab-2-content').hide()
      $('#tab-3-content').hide()
      $('#tab-4-content').hide()

      $('#tab-4').addClass('active')
      $('#tab-4-content').show()
