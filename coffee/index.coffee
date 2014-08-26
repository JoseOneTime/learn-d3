width = 960
height = 500

x = d3.scale.ordinal()
	.rangeRoundBands [0, width], 0.1

y = d3.scale.linear()
	.range [height, 0]

chart = d3.select '.chart'
	.attr 'width', width
	.attr 'height', height

type = (d) ->
	d.value = parseInt(d.value, 10)
	d

d3.tsv 'data.tsv', type, (err, data) ->
	x.domain data.map (d) -> d.name
	y.domain [0, d3.max(data, (d) -> d.value)]

	bar = chart.selectAll 'g'
		.data data
		.enter()
		.append 'g'
		.attr 'transform', (d, i) -> "translate(#{x d.name}, 0)"

	bar.append 'rect'
		.attr 'y', (d) -> y(d.value)
		.attr 'height', (d) -> height - y(d.value)
		.attr 'width', x.rangeBand()

	bar.append 'text'
		.attr 'x', x.rangeBand() / 2
		.attr 'y', (d) -> y(d.value) + 3
		.attr 'dy', '.75em'
		.text (d) -> d.value
