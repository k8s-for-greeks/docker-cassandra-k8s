# Copyright 2017 K8s For Greeks
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

VERSION?=3.11.1
PROJECT_ID?=k8s-for-greeks
PROJECT?=gcr.io/${PROJECT_ID}
CASSANDRA_VERSION?=3.11.1
CASSANDRA_HOST_IP?=$(strip $(shell ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'|tail -n 1|awk '{print $1}'))

all: build

docker:
	docker build --compress --squash --build-arg "CASSANDRA_VERSION=${CASSANDRA_VERSION}" -t ${PROJECT}/cassandra:${VERSION} .

docker-dev:
	docker build --pull --build-arg "CASSANDRA_VERSION=${CASSANDRA_VERSION}" --build-arg "DEV_CONTAINER=1" -t ${PROJECT}/cassandra:${VERSION}-dev .

docker-cached:
	docker build --compress --squash --build-arg "CASSANDRA_VERSION=${CASSANDRA_VERSION}" -t ${PROJECT}/cassandra:${VERSION} .

build: docker

build-dev: docker-dev

build-cached: docker-cached

push: build
	docker push ${PROJECT}/cassandra:${VERSION}

run: build-cached
	docker run -i -t --rm \
	-e CASSANDRA_SEEDS='172.17.0.2' \
	-e CASSANDRA_MEMTABLE_FLUSH_WRITERS=1 \
	${PROJECT}/cassandra:${VERSION}

shell: build-cached
	docker run -i -t --rm \
	-e CASSANDRA_SEEDS='172.17.0.2' \
	-e CASSANDRA_MEMTABLE_FLUSH_WRITERS=1 \
	${PROJECT}/cassandra:${VERSION} \
	/bin/bash

push-dev: build-dev
	docker push ${PROJECT}/cassandra:${VERSION}-dev

push-all: build build-dev push push-dev

.PHONY: all build push docker docker-dev build-dev push push-all
