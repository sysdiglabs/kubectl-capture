.PHONY: test

build_and_push:
	docker build -t sysdig/capture-and-sleep docker/
	docker push sysdig/capture-and-sleep

test:
	bats test/*.bats
