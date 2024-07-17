FROM fedora:latest

# Add the precice user to run test with mpi
RUN useradd -m -s /bin/bash precice
ENV PRECICE_USER=precice

# Install necessary dependencies for preCICE and PETSc
RUN dnf -y update && \
    dnf -y install \
    git \
    cmake \
    curl \
    wget \
    ccache \
    gcc-c++ \
    libasan \
    libubsan \
    libxml2-devel \
    redhat-lsb-core \
    boost-devel \
    mpich-devel \
    ninja-build \
    petsc-mpich-devel \
    eigen3-devel \
    kokkos-devel \
    python3-devel \
    python3-pip \
    google-benchmark \
    environment-modules \
    && \
    dnf clean all && \
    echo "module load mpi/mpich-x86_64" > /etc/profile.d/mpich.sh

# Run interactively using a bash login shell
COPY --chown=root:root ginkgo/99-ginkgo-env.sh /etc/profile.d/
COPY ginkgo/ginkgo-install.sh ginkgo-install.sh
RUN ./ginkgo-install.sh && rm ginkgo-install.sh
CMD [ "bash", "--login" ]
