.PHONY: build
build:
	dune build
	test -e bin || ln -s _build/install/default/bin .

.PHONY: setup
setup:
	./scripts/install-tree-sitter
	# TODO: install opam packages

# Keep things like node_modules that are worth keeping around
.PHONY: clean
clean:
	rm -r bin
	dune clean
	make -C tests clean

.PHONY: distclean
	# remove everything that's git-ignored
	git clean -dfX

.PHONY: test
test: build
	./_build/default/src/gen/test/test.exe
	./_build/default/src/run/test/test.exe
	$(MAKE) -C tests

.PHONY: install
install:
	dune install