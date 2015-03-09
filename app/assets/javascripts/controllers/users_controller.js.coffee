Crucible.UsersIndexController = Ember.ObjectController.extend

  actions:

    sideBar: (selection) ->
      d3.select(".chart")
      .selectAll("div")
      .data(data)
      .enter().append("div")
      .style("width", (d) -> return d * 10 + "px")
      .text((d) -> return d)
