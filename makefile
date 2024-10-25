ALL=archlinux centos7 fedora ubuntu-1804 ubuntu-2004 ubuntu-2204 ubuntu-2404 intel

BASEIMAGES=ubuntu:20.04 ubuntu:22.04 ubuntu:24.04 archlinux:latest fedora:latest intel/oneapi-hpckit:devel-ubuntu22.04 precice/precice:nightly

.PHONY: $(ALL)

all: $(ALL)

intel:
	docker build -t precice/ci-intel:latest -f ci-intel.dockerfile .

archlinux:
	docker build -t precice/ci-archlinux:latest -f ci-archlinux.dockerfile .

centos7:
	docker build -t precice/ci-centos7:latest -f ci-centos7.dockerfile .

fedora:
	docker build -t precice/ci-fedora:latest -f ci-fedora.dockerfile .

ubuntu-1804:
	docker build -t precice/ci-ubuntu-1804:latest -f ci-ubuntu-1804.dockerfile .

ubuntu-2004:
	docker build -t precice/ci-ubuntu-2004:latest -f ci-ubuntu-2004.dockerfile .

ubuntu-2204:
	docker build -t precice/ci-ubuntu-2204:latest -f ci-ubuntu-2204.dockerfile .

ubuntu-2404:
	docker build -t precice/ci-ubuntu-2404:latest -f ci-ubuntu-2404.dockerfile .

aste:
	docker build -t precice/ci-aste:latest -f ci-aste.dockerfile .

# Pull updated versions of all base images
pull:
	$(foreach img,$(BASEIMAGES),docker pull $(img);)

# Remove all created images
clean:
	docker rmi $(foreach img,$(ALL),ci-$(img):latest)
