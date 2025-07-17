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
        xz \
        make \
        ninja \
        python \
        python-numpy \
        python-pip \
        openssh

# TODO reactivate petsc4py once they release a fix for cython 
RUN useradd -m -G wheel aur && \
    echo "%wheel         ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    su -l aur -c "git clone https://aur.archlinux.org/petsc.git && cd petsc && sed -i "s/--with-petsc4py=1/--with-petsc4py=0/" PKGBUILD && yes | makepkg -si" && \
    userdel -rf aur && \
    yes | pacman -Scc

CMD ["/bin/bash", "--login"]
