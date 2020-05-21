build:
	mkdocs build

serve:
	mkdocs serve

publish: clean build
	cp -rv site/* fruitnanny.github.io/

	mkdir fruitnanny.github.io/debian
	cp -rv debian/dists fruitnanny.github.io/debian/
	cp -rv debian/pool fruitnanny.github.io/debian/

clean:
	rm -rf fruitnanny.github.io/*
