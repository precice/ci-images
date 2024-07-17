# Dockerfile for building preCICE on ubuntu 22.04

FROM ubuntu:24.04

# Add the precice user to run test with mpi
RUN useradd -m -s /bin/bash precice
ENV PRECICE_USER=precice

COPY ubuntu/inittimezone /usr/local/bin/inittimezone

# Installing necessary dependecies for preCICE
RUN apt-get -qq update && \
    inittimezone && \
    apt-get -qq -y install \
        build-essential \
        ccache \
        cmake \
        curl \
        g++ \
        gfortran \
        git \
        lcov \
        libbenchmark-dev \
        libboost-all-dev \
        libeigen3-dev \
        libxml2-dev \
        lintian \
        lsb-release \
        ninja-build \
        petsc-dev \
        python3-dev \
        python3-numpy \
        python3-pip \
        python3-venv \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Environment variables are set in the .env file
CMD ["/bin/bash", "--login"]
