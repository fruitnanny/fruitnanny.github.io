# FruitNanny Website

Website for the [FruitNanny](https://fruitnanny.github.io/) project. The
website is hosted via [GitHub Pages](https://pages.github.com/). 


## Installation

The website is build with [mkdocs](https://www.mkdocs.org/). Install the
following Python dependencies, preferably in a virtual environment.

```bash
pip install \
	mkdocs \
	mkdocs-material \
	mkdocs-git-revision-date-localized-plugin
```

The static Debian repository is built with
[reprepro](https://wiki.debian.org/DebianRepository/SetupWithReprepro).

```bash
sudo apt install reprepro
```


## Publishing

GitHub Pages for organization pages has the restriction that the page is
deployed directly from the content of the `master` branch. For that reason,
the main branch is `source`. The compiled website is pushed to the `master`
branch which has a completely history. 

```bash
make publish
```


## References

- https://squidfunk.github.io/mkdocs-material/
- https://pmateusz.github.io/linux/2017/06/30/linux-secure-apt-repository.html
