.PHONY: all
all: js/index.js css/style.css index.html

js/%.js: coffee/%.coffee
	coffee -co $(@D) $<

css/%.css: styl/%.styl
	@mkdir -p css
	stylus < $< > $@

%.html: %.jade
	jade $< -o $(@D)

.PHONY: clean
clean:
	rm -rf js css
	rm -f index.html
