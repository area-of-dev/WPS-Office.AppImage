# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD := $(shell pwd)

DOCKER_COMPOSE:=docker-compose -f $(PWD)/docker-compose.yaml

.EXPORT_ALL_VARIABLES:
CID=$(shell basename $(PWD) | tr -cd '[:alnum:]' | tr A-Z a-z)
UID=$(shell id -u)
GID=$(shell id -g)

.PHONY: all


all: clean
	$(DOCKER_COMPOSE) stop
	$(DOCKER_COMPOSE) up --build --no-start
	$(DOCKER_COMPOSE) up -d  "appimage"
	$(DOCKER_COMPOSE) run    "appimage" make all
	$(DOCKER_COMPOSE) run    "appimage" chown -R $(UID):$(GID) ./
	$(DOCKER_COMPOSE) stop

clean:
	$(DOCKER_COMPOSE) up -d  "appimage"
	$(DOCKER_COMPOSE) run    "appimage" make clean
	$(DOCKER_COMPOSE) rm --stop --force
