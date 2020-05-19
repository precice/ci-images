# Dockerfile for building preCICE on ubuntu 20.04

FROM ubuntu:20.04

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
        g++ \
        gfortran \
        git \
        libboost-all-dev \
        libeigen3-dev \
        libxml2-dev \
        lintian \
        petsc-dev \
        python3-dev \
        python3-numpy \
        wget \
    && rm -rf /var/lib/apt/lists/*
