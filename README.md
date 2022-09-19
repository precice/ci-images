# preCICE CI-Images

This repository contains docker for the CI of [precice/precice](https://github.com/precice/precice).
Images are updated monthly via this repository.


## Images

Name | Distribution | Purpose | Image
--- | --- | --- | ---
`archlinux`   | Arch Linux   | Latest Releases   | [DockerHub](https://hub.docker.com/r/precice/ci-archlinux)
`fedora-34`   | Fedora 34    | Workstations      | [DockerHub](https://hub.docker.com/r/precice/ci-fedora-34)
`ubuntu-2004` | Ubuntu 20.04 | Oldest Ubuntu LTS | [DockerHub](https://hub.docker.com/r/precice/ci-ubuntu-2004)
`ubuntu-2204` | Ubuntu 22.04 | Newest Ubuntu LTS | [DockerHub](https://hub.docker.com/r/precice/ci-ubuntu-2204)

## Building Locally

* Install [Docker](https://www.docker.com/get-started)
* Install `make`
* Run `make` followed by the name to build the image. Example: `make ubuntu-2004`

## Guidelines for CI Images

* Provide `git cmake make wget curl g++ ccache`
* Provide all preCICE dependencies.  
  Prefer the officially packaged versions and install from source if necessary.
  Install custom software in `/opt/` and set required variables (`LD_LIBRARY_PATH`, `CPATH`, `PKG_CONFIG_PATH`) using a file in `/etc/profile.d/`.
* Add the user `precice` with a home directory.  
  Specify `ENV PRECICE_USER precice`.
  This user must be able to clone, build and test preCICE.
* For ubuntu images, additionally provide `lintian` and `lcov`
