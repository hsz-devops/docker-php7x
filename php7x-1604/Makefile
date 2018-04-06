DCOMP=docker-compose -f ./docker-compose.yml -f ./docker-compose.p3ansible.yml $*
#NOCACHE=--no-cache

include Make.php7x-70.make
include Make.php7x-71.make
include Make.php7x-72.make

# ----------------------------------------------------------
.PHONY: all
all: build-1604-all
all: push-1604-all

.PHONY: build-1604-all
build-1604-all: build-1604-all-70
build-1604-all: build-1604-all-71
build-1604-all: build-1604-all-72

.PHONY: build-1604-all-apache
build-1604-all-apache: build-70-apache-1604
build-1604-all-apache: build-71-apache-1604
build-1604-all-apache: build-72-apache-1604

.PHONY: push-1604-all
push-1604-all: push-1604-all-70
push-1604-all: push-1604-all-71
push-1604-all: push-1604-all-72

.PHONY: pull-1604-all
pull-1604-all:
	$(DCOMP) pull
