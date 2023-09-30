# Dockerfile for building preCICE on ubuntu 22.04 with the intel oneAPI HPC Kit

FROM intel/oneapi-hpckit:devel-ubuntu22.04

# Add the precice user to run test with mpi
RUN useradd -m -s /bin/bash precice
ENV PRECICE_USER=precice

# Installing necessary dependecies for preCICE
RUN apt-get -qq update && \
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
        python3-dev \
        python3-numpy \
        python3-pip \
        wget \
    && rm -rf /var/lib/apt/lists/*

RUN git clone -b release --depth 1 https://gitlab.com/petsc/petsc.git /petsc && \
    cd /petsc && \
    export I_MPI_CC=icx I_MPI_CXX=icpx I_MPI_FC=ifx && \
    ./configure --with-cc=mpicc --with-cxx=mpicxx --with-fc=mpifc --prefix=/usr/local/ && \
    make && \
    make install && \
    rm -rf /petsc

COPY --chown=root:root intel/99-setup-intel.sh /etc/profile.d/


# Environment variables are set in the .env file
# COPY --chown=root:root ginkgo/99-ginkgo-env.sh /etc/profile.d/
# COPY ginkgo/ginkgo-install.sh ginkgo-install.sh
# RUN ./ginkgo-install.sh && rm ginkgo-install.sh
CMD ["/bin/bash", "--login"]
