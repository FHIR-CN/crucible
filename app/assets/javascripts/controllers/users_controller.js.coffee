Crucible.UsersIndexController = Ember.ObjectController.extend

  actions:
    # click: (selection) ->
    #   $tab = '#' + selection
    #   $content = $tab + "-content"
    #   $details = $tab + "-details"

    #   $('#tab-1').removeClass('active')
    #   $('#tab-2').removeClass('active')
    #   # $('#tab-3').removeClass('active')
    #   # $('#tab-4').removeClass('active')

    #   $('#tab-1-content').hide()
    #   $('#tab-2-content').hide()
    #   # $('#tab-3-content').hide()
    #   # $('#tab-4-content').hide()

    #   $('#tab-1-details').hide()
    #   $('#tab-2-details').hide()
    #   # $('#tab-3-details').hide()
    #   # $('#tab-4-details').hide()

    #   $($tab).addClass('active')
    #   $($content).show()
    #   $($details).show()

    sideBar: (selection) ->
      d3.select(".chart")
      .selectAll("div")
      .data(data)
      .enter().append("div")
      .style("width", (d) -> return d * 10 + "px")
      .text((d) -> return d)
