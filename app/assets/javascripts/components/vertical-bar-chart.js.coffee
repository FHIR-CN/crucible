Crucible.VerticalBarChartComponent = Ember.Component.extend

  didInsertElement: ->
    svg = d3.select("##{@elementId}").select("svg")
    padding = 5
    @width = 600 - padding * 2
    @height = 200 - padding * 2
    data = @data
    @barScale = d3.scale.ordinal()
      .domain(d3.range(0, data.length))
      .rangeRoundBands([padding, @width], (@bandPadding||0))
    @heightScale = d3.scale.linear()
      .domain([0, d3.max(data, (d) -> d.value)])
      .range([padding, @height])
    @g = svg.append("g")
    gEnter = @g.selectAll("rect")
      .data(data)
      .enter()
    gEnter.append("rect")
      .style("fill", '#7F9FC5') 
      .attr("x", (d,i) => @barScale(i))
      .attr("y", (d) => @height )
      .attr("width", @barScale.rangeBand())
      .attr("height", 0)
    @g.selectAll("rect")
      .transition()
      .style("fill", '#7F9FC5')
      .attr("x", (d,i) => @barScale(i))
      .attr("y", (d) => @height - @heightScale(d.value))
      .attr("width", @barScale.rangeBand())
      .attr("height", (d) => @heightScale(d.value))

  updateGraph:(->
    @g.selectAll("rect")
      .data(@data)
      .transition()
      .style("fill", '#7F9FC5')
      .attr("x", (d,i) => @barScale(i))
      .attr("y", (d) => @height - @heightScale(d.value))
      .attr("width", @barScale.rangeBand())
      .attr("height", (d) => @heightScale(d.value))
    ).observes('data')
