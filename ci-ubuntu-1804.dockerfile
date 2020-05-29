# Dockerfile for building preCICE on ubuntu 18.04

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
        ccache \
        cmake  \
        g++ \
        gfortran \
        git \
        lcov \
        libblas-dev \
        libboost-all-dev \
        libeigen3-dev \
        liblapack-dev \
        libopenmpi-dev \
        libxml2-dev \
        lintian \
        python \
        python3-dev \
        python3-numpy \
        wget \
    && rm -rf /var/lib/apt/lists/*

COPY --chown=root:root eigen3/99-eigen3-env.sh /etc/profile.d/
COPY --chown=root:root petsc/99-petsc-env.sh /etc/profile.d/
COPY petsc/petsc-install.sh petsc-install.sh
RUN ./petsc-install.sh && rm petsc-install.sh

CMD ["/bin/bash", "--login"]
