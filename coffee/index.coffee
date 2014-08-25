width = 420
barHeight = 20

x = d3.scale.linear()
	.range [0, width]

chart = d3.select ".chart"
	.attr "width", width

type = (d) ->
	d.value = parseInt d.value, 10
	d

d3.tsv 'data.tsv', type, (err, data) ->
	x.domain [0, d3.max(data, (d) -> d.value)]
	chart.attr 'height', barHeight * data.length
	bar = chart.selectAll "g"
			.data data
		.enter().append "g"
			.attr "transform", (d, i) -> "translate(0,#{i * barHeight})"
	bar.append 'rect'
		.attr 'width', (d) -> x d.value
		.attr 'height', barHeight - 1
	bar.append 'text'
		.attr 'x', (d) -> x(d.value) - 3
		.attr 'y', barHeight / 2
		.attr 'dy', '.35em'
		.text (d) -> d.value
