.PHONY: build
build: build/SRPMS/activemq-artemis-SNAPSHOT.src.rpm

.PHONY: clean
clean:
	rm -rf build

.PHONY: test
test: build/SRPMS/activemq-artemis-SNAPSHOT.src.rpm
	rpmbuild -D "_topdir ${PWD}/build" --rebuild $<
	@echo "Output: ${PWD}/$$(find build/RPMS -type f)"

build/commit:
	@mkdir -p build
	scripts/github-get-commit apache activemq-artemis HEAD > $@

build/SPECS/activemq-artemis.spec: activemq-artemis.spec.in build/commit
	@mkdir -p build/SPECS
	scripts/configure-file -a commit=$$(cat build/commit) $< $@

build/SOURCES/activemq-artemis-SNAPSHOT.tar.gz: build/commit
	@mkdir -p build/SOURCES
	scripts/github-get-archive apache activemq-artemis $$(cat $<) $@

build/SOURCES/artemis.service: artemis.service
	@mkdir -p build/SOURCES
	cp $< $@

build/SRPMS/activemq-artemis-SNAPSHOT.src.rpm: build/SPECS/activemq-artemis.spec \
		build/SOURCES/activemq-artemis-SNAPSHOT.tar.gz \
		build/SOURCES/artemis.service
	rm -f build/SRPMS/*
	rpmbuild -D "_topdir ${PWD}/build" -bs $<
	cp build/SRPMS/activemq-artemis-*.src.rpm $@
	@echo "Output: ${PWD}/$@"
