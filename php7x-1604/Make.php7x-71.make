.PHONY: build-1604-all-71
build-1604-all-71: build-71-cli-1604
build-1604-all-71: build-71-apache-1604
build-1604-all-71: build-71-fpm-1604

# ----------------------------------------------------------
.PHONY: build-71-cli-1604 build-71-apache-1604 build-71-fpm-1604
build-71-cli-1604:
	$(DCOMP) build php71-cli-1604
	$(DCOMP) build php71-cli-1604-py3ans

build-71-apache-1604: build-71-cli-1604
	$(DCOMP) build php71-apache-1604
	$(DCOMP) build php71-apache-1604-py3ans

build-71-fpm-1604: build-71-cli-1604
	$(DCOMP) build php71-fpm-1604
	$(DCOMP) build php71-fpm-1604-py3ans

# ==========================================================
.PHONY: push-1604-all-71
push-1604-all-71: push-71-cli-1604
push-1604-all-71: push-71-apache-1604
push-1604-all-71: push-71-fpm-1604

# ----------------------------------------------------------
.PHONY: push-71-cli-1604 push-71-apache-1604 push-71-fpm-1604
push-71-cli-1604:
	$(DCOMP) push php71-cli-1604
	$(DCOMP) push php71-cli-1604-py3ans

push-71-apache-1604:
	$(DCOMP) push php71-apache-1604
	$(DCOMP) push php71-apache-1604-py3ans

push-71-fpm-1604:
	$(DCOMP) push php71-fpm-1604
	$(DCOMP) push php71-fpm-1604-py3ans
