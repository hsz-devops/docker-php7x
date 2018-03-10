DCOMP=docker-compose -f ../docker-compose.yml $*
#NOCACHE=--no-cache
.PHONY: all
all: build-1604-cli
all: build-1604-apache
all: build-1604-fpm
#all: build-deb-fpm
#all: build-alp-fpm

.PHONY: build-1604-cli
build-1604-cli:
	$(DCOMP) build $(NOCACHE) php70-cli-1604
	$(DCOMP) build $(NOCACHE) php72-cli-1604

push-1604-cli:
	$(DCOMP) push php70-cli-1604
	$(DCOMP) push php72-cli-1604

.PHONY: build-1604-apache
build-1604-apache: build-1604-cli
	$(DCOMP) build $(NOCACHE) php72-apa-1604
	$(DCOMP) build $(NOCACHE) php70-apa-1604

.PHONY: build-1604-fpm
build-1604-fpm: build-1604-cli
	$(DCOMP) build $(NOCACHE) php72-fpm-1604
	$(DCOMP) build $(NOCACHE) php70-fpm-1604

.PHONY: push-1604-apache
push-1604-apache: push-1604-cli
	$(DCOMP) push php72-apa-1604
	$(DCOMP) push php70-apa-1604

.PHONY: push-1604-fpm
push-1604-fpm: push-1604-cli
	$(DCOMP) push php72-fpm-1604
	$(DCOMP) push php70-fpm-1604

# .PHONY: dc-build-phpbase7x-deb
# dc-build-phpbase7x-deb: dc-build-phpbase72-deb dc-build-phpbase70-deb
#
# .PHONY: dc-build-phpbase72-deb
# dc-build-phpbase72-deb:
# 	$(DCOMP) build $(NOCACHE) php72-fpm-deb
#
# .PHONY: dc-build-phpbase70-deb
# dc-build-phpbase70-deb:
# 	$(DCOMP) build $(NOCACHE) php70-fpm-deb

