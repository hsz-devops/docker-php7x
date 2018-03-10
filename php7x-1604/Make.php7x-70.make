.PHONY: build-1604-all-70
build-1604-all-70: build-70-cli-1604    build-70-cli-1604-py3ans
build-1604-all-70: build-70-apache-1604 build-70-apache-1604-py3ans
build-1604-all-70: build-70-fpm-1604    build-70-fpm-1604-py3ans

# ----------------------------------------------------------
.PHONY: build-70-cli-1604 build-70-apache-1604 build-70-fpm-1604
build-70-cli-1604:
	$(DCOMP) build php70-cli-1604

build-70-apache-1604: build-70-cli-1604
	$(DCOMP) build php70-apache-1604

build-70-fpm-1604: build-70-cli-1604
	$(DCOMP) build php70-fpm-1604

# ----------------------------------------------------------
.PHONY: build-70-cli-1604-py3ans build-70-apache-1604-py3ans build-70-fpm-1604-py3ans
build-70-cli-1604-py3ans: build-70-cli-1604
	$(DCOMP) build $(NOCACHE) php70-cli-1604-py3ans

build-70-apache-1604-py3ans: build-70-apache-1604
	$(DCOMP) build $(NOCACHE) php70-apache-1604-py3ans

build-70-fpm-1604-py3ans: build-70-fpm-1604
	$(DCOMP) build $(NOCACHE) php70-fpm-1604-py3ans

# ==========================================================
.PHONY: push-1604-all-70
push-1604-all-70: push-70-cli-1604    push-70-cli-1604-py3ans
push-1604-all-70: push-70-apache-1604 push-70-apache-1604-py3ans
push-1604-all-70: push-70-fpm-1604    push-70-fpm-1604-py3ans

# ----------------------------------------------------------
.PHONY: push-70-cli-1604 push-70-apache-1604 push-70-fpm-1604
push-70-cli-1604:
	$(DCOMP) push php70-cli-1604

push-70-apache-1604: push-70-cli-1604
	$(DCOMP) push php70-apache-1604

push-70-fpm-1604: push-70-cli-1604
	$(DCOMP) push php70-fpm-1604

# ----------------------------------------------------------
.PHONY: push-70-cli-1604-py3ans push-70-apache-1604-py3ans push-70-fpm-1604-py3ans
push-70-cli-1604-py3ans: push-70-cli-1604
	$(DCOMP) push $(NOCACHE) php70-cli-1604-py3ans

push-70-apache-1604-py3ans: push-70-apache-1604
	$(DCOMP) push $(NOCACHE) php70-apache-1604-py3ans

push-70-fpm-1604-py3ans: push-70-fpm-1604
	$(DCOMP) push $(NOCACHE) php70-fpm-1604-py3ans
