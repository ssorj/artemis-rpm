.PHONY: build
build: build/SRPMS/activemq-artemis.src.rpm

.PHONY: clean
clean:
	rm -rf build

.PHONY: test
test: build/SRPMS/activemq-artemis.src.rpm
	rpmbuild -D "_topdir ${PWD}/build" --rebuild $<
	@echo "Output: $$(find build/RPMS -type f)"

build/commit:
	@mkdir -p build
	scripts/github-get-commit apache activemq-artemis HEAD > $@

build/SPECS/activemq-artemis.spec: activemq-artemis.spec.in build/commit
	@mkdir -p build/SPECS build/SOURCES
	scripts/configure-file -a commit=$$(cat build/commit) $< $@

build/SRPMS/activemq-artemis.src.rpm: build/SPECS/activemq-artemis.spec
	scripts/github-get-archive apache activemq-artemis $$(cat build/commit) build/SOURCES/$$(cat build/commit).tar.gz
	rpmbuild -D "_topdir ${PWD}/build" -bs $<
	mv build/SRPMS/activemq-artemis-*.src.rpm $@
	@echo "Output: $@"
