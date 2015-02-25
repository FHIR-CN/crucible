Crucible.ServersShowView = Em.View.extend
  didInsertElement: ->
    # Any d3 related code you have should go in here.
    # Or at least kicked off from here
    # Here's a silly little bit of code to cycle the nav-circles
    window.active = 1
    window.setInterval(() ->
      window.active++
      window.active = window.active % 3
      d3.selectAll(".nav-circle").classed("filled", (d,i) -> i == window.active)
    , 1000)
