.PHONY: all
all: js/index.js

js/%.js: coffee/%.coffee
	coffee -co $(@D) $<

.PHONY: clean
clean:
	rm -r js
