margin =
	top: 20
	right: 30
	bottom: 30
	left: 40

outerWidth = 960
outerHeight = 500
width = outerWidth - margin.left - margin.right
height = outerHeight - margin.top - margin.bottom

x = d3.scale.ordinal()
	.rangeRoundBands [0, width], 0.1

y = d3.scale.linear()
	.range [height, 0]

xAxis = d3.svg.axis()
	.scale x
	.orient 'bottom'

yAxis = d3.svg.axis()
	.scale y
	.orient 'left'
	.ticks 10, '%'

chart = d3.select '.chart'
	.attr 'width', outerWidth
	.attr 'height', outerHeight
	.append 'g'
	.attr 'transform', "translate(#{margin.left}, #{margin.top})"

type = (d) ->
	d.value = parseInt d.value, 10
	d

d3.tsv 'data.tsv', type, (err, data) ->
	x.domain data.map (d) -> d.name
	y.domain [0, d3.max(data, (d) -> d.value)]

	chart.append 'g'
		.attr 'class', 'x axis'
		.attr 'transform', "translate(0, #{height})"
		.call xAxis

	chart.append 'g'
		.attr 'class', 'y axis'
		.call yAxis
		.append 'text'
		.attr 'transform', 'rotate(-90)'
		.attr 'y', 6
		.attr 'dy', '.71em'
		.style 'text-anchor', 'end'
		.text 'Frequency'

	chart.selectAll '.bar'
		.data data
		.enter()
		.append 'rect'
		.attr 'class', 'bar'
		.attr 'x', (d) -> x d.name
		.attr 'y', (d) -> y d.value
		.attr 'height', (d) -> height - y d.value
		.attr 'width', x.rangeBand()
