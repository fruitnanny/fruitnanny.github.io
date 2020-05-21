#!/bin/bash
prev=$(git -C public/ log --format=%s | grep -oP "(?<=^Publish commit )[a-z0-9]{40}$" | head -n1)

if [[ "$prev" == "" ]]; then
	echo "Error: cannot find previous commit" > /dev/stderr
	exit 1
fi

cat <<EOL | git -C public/ commit -F -
Publish commit $(git rev-parse HEAD)

This includes the following commits:

$(git log --format="%h %s" "$prev..HEAD")
EOL
