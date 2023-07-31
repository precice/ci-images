FROM archlinux:latest

# Add the precice user to run test with mpi
RUN useradd -m -s /bin/bash precice
ENV PRECICE_USER precice

# Install necessary dependencies for preCICE
# Installing PETSc from AUR requires a non-root user
RUN pacman -Syu --needed --noconfirm \
        base-devel \
        benchmark \
        boost \
        ccache \
        clang \
        cmake \
        curl \
        eigen \
        gcc \
        gcc-fortran \
        git \
        libxml2 \
        make \
        python \
        python-numpy \
        python-pip \
        python-venv \
        openssh

COPY arch/setuparch4edu /usr/local/bin/setuparch4edu
RUN setuparch4edu && \
    pacman -S --noconfirm petsc  && \
    yes | pacman -Scc

CMD ["/bin/bash", "--login"]
