# Dockerfile for building preCICE on ubuntu with the intel oneAPI compilers and MPI

FROM ubuntu:24.04

## Install and setup Intel oneAPI

# Disable autoremoval of packages
RUN rm -f /etc/apt/apt.conf.d/docker-clean

# Add Intel repo and install packages
RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && apt-get upgrade -y && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get install -y --no-install-recommends curl ca-certificates gpg-agent software-properties-common apt-utils && \
  curl -fsSL https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB | gpg --dearmor -o /usr/share/keyrings/intel-oneapi-archive-keyring.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/intel-oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main " > /etc/apt/sources.list.d/oneAPI.list && \
  apt-get update && \
  \
  apt-get install -y --no-install-recommends build-essential pkg-config gnupg libarchive13 openssh-server openssh-client wget net-tools git && \
  apt-get install -y --no-install-recommends intel-oneapi-mpi-devel intel-oneapi-compiler-dpcpp-cpp intel-oneapi-compiler-fortran && \
  rm -rf /var/lib/apt/lists/*

# Check if Intel compilers are available
RUN . /opt/intel/oneapi/setvars.sh icx --version && icpx --version && ifx --version 

# Add the precice user to run test with mpi
RUN useradd -m -s /bin/bash precice
ENV PRECICE_USER=precice

# Installing necessary dependecies for preCICE
RUN --mount=type=cache,target=/var/cache/apt \
    apt-get -qq update && \
    apt-get -qq -y install \
        build-essential \
        ccache \
        cmake \
        curl \
        git \
        libboost-all-dev \
        libeigen3-dev \
        libxml2-dev \
        lsb-release \
        ninja-build \
        python3-dev \
        python3-numpy \
        python3-pip \
        python3-venv \
        wget \
        liblapack-dev \
        libbenchmark-dev \
    && rm -rf /var/lib/apt/lists/*

# NO MORE APT INSTALLS AFTER THIS LINE
# Cleanup leftover packages
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*


RUN . /opt/intel/oneapi/setvars.sh && \
    git clone -b release --depth 1 https://gitlab.com/petsc/petsc.git /petsc && \
    cd /petsc && \
    export I_MPI_CC=icx I_MPI_CXX=icpx I_MPI_FC=ifx && \
    ./configure --with-cc=mpicc --with-cxx=mpicxx --with-fc=mpifc --prefix=/usr/local/ && \
    make && \
    make install && \
    rm -rf /petsc

COPY --chown=root:root intel/99-setup-intel.sh /etc/profile.d/


CMD ["/bin/bash", "--login"]

# vim: set ft=dockerfile :
