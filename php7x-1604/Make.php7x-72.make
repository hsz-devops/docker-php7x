.PHONY: build-1604-all-72
build-1604-all-72: build-72-cli-1604    build-72-cli-1604-py3ans
build-1604-all-72: build-72-apache-1604 build-72-apache-1604-py3ans
build-1604-all-72: build-72-fpm-1604    build-72-fpm-1604-py3ans

# ----------------------------------------------------------
.PHONY: build-72-cli-1604 build-72-apache-1604 build-72-fpm-1604
build-72-cli-1604:
	$(DCOMP) build php72-cli-1604

build-72-apache-1604: build-72-cli-1604
	$(DCOMP) build php72-apache-1604

build-72-fpm-1604: build-72-cli-1604
	$(DCOMP) build php72-fpm-1604

# ----------------------------------------------------------
.PHONY: build-72-cli-1604-py3ans build-72-apache-1604-py3ans build-72-fpm-1604-py3ans
build-72-cli-1604-py3ans: build-72-cli-1604
	$(DCOMP) build $(NOCACHE) php72-cli-1604-py3ans

build-72-apache-1604-py3ans: build-72-apache-1604
	$(DCOMP) build $(NOCACHE) php72-apache-1604-py3ans

build-72-fpm-1604-py3ans: build-72-fpm-1604
	$(DCOMP) build $(NOCACHE) php72-fpm-1604-py3ans

# ==========================================================
.PHONY: push-1604-all-72
push-1604-all-72: push-72-cli-1604    push-72-cli-1604-py3ans
push-1604-all-72: push-72-apache-1604 push-72-apache-1604-py3ans
push-1604-all-72: push-72-fpm-1604    push-72-fpm-1604-py3ans

# ----------------------------------------------------------
.PHONY: push-72-cli-1604 push-72-apache-1604 push-72-fpm-1604
push-72-cli-1604:
	$(DCOMP) push php72-cli-1604

push-72-apache-1604: push-72-cli-1604
	$(DCOMP) push php72-apache-1604

push-72-fpm-1604: push-72-cli-1604
	$(DCOMP) push php72-fpm-1604

# ----------------------------------------------------------
.PHONY: push-72-cli-1604-py3ans push-72-apache-1604-py3ans push-72-fpm-1604-py3ans
push-72-cli-1604-py3ans: push-72-cli-1604
	$(DCOMP) push $(NOCACHE) php72-cli-1604-py3ans

push-72-apache-1604-py3ans: push-72-apache-1604
	$(DCOMP) push $(NOCACHE) php72-apache-1604-py3ans

push-72-fpm-1604-py3ans: push-72-fpm-1604
	$(DCOMP) push $(NOCACHE) php72-fpm-1604-py3ans
