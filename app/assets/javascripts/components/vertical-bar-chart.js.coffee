Crucible.VerticalBarChartComponent = Ember.Component.extend
  data: [{risk: 1, label: "1", value: 1}, 
  {label: "2", value: 1}, 
  {label: "3", value: 1}, 
  {label: "4", value: 15}, 
  {label: "5", value: 1}, 
  {label: "6", value: 1},
  {label: "7", value: 13}, 
  {label: "8", value: 41}, 
  {label: "9", value: 1}, 
  {label: "10", value: 1}, 
  {label: "11", value: 19}, 
  {label: "12", value: 8}, 
  {label: "13", value: 3}, 
  {label: "14", value: 1},
  {label: "15", value: 57}, 
  {label: "16", value: 41}, 
  {label: "17", value: 12},
  {label: "18", value: 5}, 
  {label: "19", value: 13}, 
  {label: "20", value: 3},
  {label: "21", value: 5},  
  {label: "22", value: 3}, 
  {label: "23", value: 1}, 
  {label: "24", value: 8}, 
  {label: "25", value: 6}, 
  {label: "26", value: 1},
  {label: "27", value: 31}, 
  {label: "28", value: 13}, 
  {label: "29", value: 14}, 
  {label: "30", value: 41},   
  {label: "31", value: 1}   
  ]

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
