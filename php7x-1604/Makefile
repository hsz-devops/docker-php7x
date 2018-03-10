DCOMP=docker-compose -f ../docker-compose.yml $*
#NOCACHE=--no-cache
.PHONY: all
all: build-1604-cli
all: build-1604-apache
all: build-1604-fpm
#all: build-deb-fpm
#all: build-alp-fpm

# ----------------------------------------------------------
.PHONY: build-1604
build-1604:
	# not in dependencies because the need to be done in sequence
	make build-1604-cli
	make build-1604-apache

.PHONY: build-1604-cli
build-1604-cli:
	$(DCOMP) build $(NOCACHE) php70-cli-1604
	$(DCOMP) build $(NOCACHE) php72-cli-1604

.PHONY: build-1604-apache
#build-1604-apache: build-1604-cli
build-1604-apache:
	$(DCOMP) build $(NOCACHE) php70-apache-1604
	$(DCOMP) build $(NOCACHE) php72-apache-1604

.PHONY: build-1604-fpm
#build-1604-fpm: build-1604-cli
build-1604-fpm:
	$(DCOMP) build $(NOCACHE) php70-fpm-1604
	$(DCOMP) build $(NOCACHE) php72-fpm-1604

# ----------------------------------------------------------
.PHONY: push-1604-cli
push-1604-cli:
	$(DCOMP) push php70-cli-1604
	$(DCOMP) push php72-cli-1604

.PHONY: push-1604-apache
push-1604-apache: push-1604-cli
	$(DCOMP) push php70-apache-1604
	$(DCOMP) push php72-apache-1604

.PHONY: push-1604-fpm
push-1604-fpm: push-1604-cli
	$(DCOMP) push php70-fpm-1604
	$(DCOMP) push php72-fpm-1604

# ----------------------------------------------------------
