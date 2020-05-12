# Dockerfile for building preCICE on ubuntu 18.04
#
FROM ubuntu:18.04

# Add the precice user to run test with mpi
RUN useradd -m -s /bin/bash precice
ENV PRECICE_USER=precice

COPY ubuntu/inittimezone /usr/local/bin/inittimezone

# Install necessary dependencies for preCICE
RUN apt-get -qq update && \
    inittimezone && \
    apt-get -qq -y install \
    build-essential \
    bzip2 \
    cmake  \
    g++ \
    gfortran \
    git \
    libboost-all-dev \
    libeigen3-dev \
    libxml2-dev \
    lintian
    python-dev \
    python-numpy \
    wget \
    && rm -rf /var/lib/apt/lists/*

ADD --chown=root:root petsc/99-petsc-env.sh /etc/profile.d/
ADD petsc/petsc-install.sh .
RUN petsc-install.sh

# Setting some environment variables for installing preCICE
ENV CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:/usr/include/eigen3" \
    CPATH="/usr/include/eigen3:${CPATH}" \
    PETSC_DIR="/usr/lib/petscdir/3.6.2/" \
    PETSC_ARCH="x86_64-linux-gnu-real"
