.PHONY: archlinux centos7 formatting ubuntu-1804 ubuntu-2004

archlinux:
	docker build -t precice/ci-archlinux:latest -f ci-archlinux.dockerfile .

centos7:
	docker build -t precice/ci-centos7:latest -f ci-centos7.dockerfile .

formatting:
	docker build -t precice/ci-formatting:latest -f ci-formatting.dockerfile .

ubuntu-1804:
	docker build -t precice/ci-ubuntu-1804:latest -f ci-ubuntu-1804.dockerfile .

ubuntu-2004:
	docker build -t precice/ci-ubuntu-2004:latest -f ci-ubuntu-2004.dockerfile .
