export SHELL=/bin/bash
export PWD=$(shell pwd)
export OS ?= $(shell uname -s | tr '[:upper:]' '[:lower:]')
export OS_ARCH ?= $(shell uname -m | sed 's/x86_64/amd64/g')

TMP ?= /tmp
TERRAFORM ?= /home/vmatukumalli/.local/bin/terraform
TERRAFORM_VERSION ?= 1.2.5
TERRAFORM_URL ?= https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/terraform_$(TERRAFORM_VERSION)_$(OS)_$(OS_ARCH).zip

terraform/install:
	@[ -x $(TERRAFORM) ] || ( \
		echo "Installing terraform $(TERRAFORM_VERSION) ($(OS)) from $(TERRAFORM_URL)" && \
		curl '-#' -fL -o $(TMP)/terraform.zip $(TERRAFORM_URL) && \
		unzip -q -d $(TMP)/ $(TMP)/terraform.zip && \
		mv $(TMP)/terraform $(TERRAFORM) && \
		rm -f $(TMP)/terraform.zip \
	)
	$(TERRAFORM) version

terraform/validate:
	@$(TERRAFORM) validate

terraform/fmt:
		@$(TERRAFORM) fmt -write=false