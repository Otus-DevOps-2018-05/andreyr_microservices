username = positive
.DEFAULT_GOAL := all

build: build-cloudprober build-prometheus build-comment build-ui build-post
build-cloudprober:
	cd $(CURDIR)/../monitoring/cloudprober && docker build -t $(username)/cloudprober .
build-prometheus:
	cd $(CURDIR)/../monitoring/prometheus && docker build -t $(username)/prometheus .
build-comment:
	cd $(CURDIR)/../src/comment && bash docker_build.sh
build-ui:
	cd $(CURDIR)/../src/ui && bash docker_build.sh
build-post:
	cd $(CURDIR)/../src/post-py && bash docker_build.sh

push: push-cloudprober push-prometheus push-comment push-ui push-post
push-cloudprober:
	docker push $(username)/cloudprober
push-prometheus:
	docker push $(username)/prometheus
push-comment:
	docker push $(username)/comment
push-ui:
	docker push $(username)/ui
push-post:
	docker push $(username)/post

all: build push
