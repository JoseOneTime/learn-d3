data = [4, 8, 15, 16, 23, 42]

x = d3.scale.linear()
	.domain [0, d3.max data]
	.range [0, 420]

d3.select ".chart"		# select first el with class chart
	.selectAll "div"	# select all divs in that el
		.data data		# join / assign data to this selection
	.enter().append "div"	# specify how these elements "enter"
		.style "width", (d) -> "#{x d}px"
		.text (d) -> d
