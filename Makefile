.PHONY: all
all: js/index.js index.html

js/%.js: coffee/%.coffee
	coffee -co $(@D) $<

%.html: %.jade
	jade $< -o $(@D)

.PHONY: clean
clean:
	rm -r js
	rm index.html
