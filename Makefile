build:
	mkdocs build

serve:
	mkdocs serve

publish: build public/
	rm -rf public/*
	cp -rv site/* public/

	mkdir public/debian
	cp -rv debian/dists public/debian/
	cp -rv debian/pool public/debian/

	git -C public/ add .
	scripts/git-commit.sh

public/:
	git worktree add public/ master
