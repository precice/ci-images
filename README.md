# preCICE CI-Images

This repository contains docker for the CI of [precice/precice](https://github.com/precice/precice).
Images are updated monthly via this repository.


## Images

Name | Distribution | Purpose | Image | Status
--- | --- | --- | --- | ---
`archlinux`   | Arch Linux     | Latest Releases   | [DockerHub](https://hub.docker.com/r/precice/ci-archlinux)   | [![Update Arch Linux](https://github.com/precice/ci-images/actions/workflows/archlinux.yml/badge.svg)](https://github.com/precice/ci-images/actions/workflows/archlinux.yml)
`fedora`      | Fedora (latest)| Workstations MPICH| [DockerHub](https://hub.docker.com/r/precice/ci-fedora)      | [![Update Fedora](https://github.com/precice/ci-images/actions/workflows/fedora.yml/badge.svg)](https://github.com/precice/ci-images/actions/workflows/fedora.yml)
`ubuntu-2004` | Ubuntu 20.04   | Oldest Ubuntu LTS | [DockerHub](https://hub.docker.com/r/precice/ci-ubuntu-2004) | [![Update Ubuntu 20.04](https://github.com/precice/ci-images/actions/workflows/ubuntu-2004.yml/badge.svg)](https://github.com/precice/ci-images/actions/workflows/ubuntu-2004.yml)
`ubuntu-2204` | Ubuntu 22.04   | Newest Ubuntu LTS | [DockerHub](https://hub.docker.com/r/precice/ci-ubuntu-2204) | [![Update Ubuntu 22.04](https://github.com/precice/ci-images/actions/workflows/ubuntu-2204.yml/badge.svg)](https://github.com/precice/ci-images/actions/workflows/ubuntu-2204.yml)
`ubuntu-2404` | Ubuntu 24.04   | Upcoming Ubuntu LTS | [DockerHub](https://hub.docker.com/r/precice/ci-ubuntu-2404) | [![Update Ubuntu 24.04](https://github.com/precice/ci-images/actions/workflows/ubuntu-2404.yml/badge.svg)](https://github.com/precice/ci-images/actions/workflows/ubuntu-2404.yml)
`intel`       | Ubuntu 22.04   | [Intel oneAPI HPC Toolkit](https://www.intel.com/content/www/us/en/developer/tools/oneapi/hpc-toolkit.html) | [DockerHub](https://hub.docker.com/r/precice/ci-intel) | :warning: must be build and pushed locally as the base image exceeds the [14GB of storage on runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners/about-github-hosted-runners#supported-runners-and-hardware-resources)

<!-- [![Update Intel](https://github.com/precice/ci-images/actions/workflows/intel.yml/badge.svg)](https://github.com/precice/ci-images/actions/workflows/intel.yml) -->

## Automatic update

The images are automatically updated monthly.

[![Monthly Update](https://github.com/precice/ci-images/actions/workflows/monthly.yml/badge.svg)](https://github.com/precice/ci-images/actions/workflows/monthly.yml)

## Building Locally

* Install [Docker](https://www.docker.com/get-started)
* Install `make`
* Run `make` followed by the name to build the image. Example: `make ubuntu-2004`

## Guidelines for CI Images

* Provide `git cmake make wget curl g++ ccache ninja`
* Provide all preCICE dependencies.  
  Prefer the officially packaged versions and install from source if necessary.
  Install custom software in `/opt/` and set required variables (`LD_LIBRARY_PATH`, `CPATH`, `PKG_CONFIG_PATH`) using a file in `/etc/profile.d/`.
* Add the user `precice` with a home directory.  
  Specify `ENV PRECICE_USER precice`.
  This user must be able to clone, build and test preCICE.
* For ubuntu images, additionally provide `lintian` and `lcov`
