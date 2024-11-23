SOURCES = README.md
PUBLICFILES = index.html

# We make this site with "make" locally and deploy generated pages to GitHub in
# a branch. First, delete the build directory and the gh-pages branch. Then
# copy the site files into the build directory and make the gh-pages target
deploy:
	(git branch -D gh-pages || true) &> /dev/null
	rm -rf build && mkdir -p build
	cp -a Makefile .git $(PUBLICFILES) build
	make -C build gh-pages
	rm -rf build

# This target only runs inside the build directory and does a commit and push
# on the gh-pages branch. If you look at this project on GitHub you should see
# the original .md files on the main branch and the generated HTML files on the
# gh-pages branch.
gh-pages:
	basename `pwd` | grep -q build || exit 1
	rm -f .git/hooks/pre-push
	git checkout -b gh-pages
	git add -f $(PUBLICFILES)
	# git rm -f $(SOURCES)
	git commit -m "this is a temporary branch, do not commit here."
	git push -f origin gh-pages:gh-pages