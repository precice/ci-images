FROM archlinux:latest

# Add the precice user to run test with mpi
RUN useradd -m -s /bin/bash precice
ENV PRECICE_USER precice

# Install necessary dependencies for preCICE
# Installing PETSc from AUR requires a non-root user
RUN pacman -Syu --needed --noconfirm \
        base-devel \
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
        openssh

RUN useradd -m -G wheel aur && \
    echo "%wheel         ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    su -l aur -c "git clone https://aur.archlinux.org/petsc.git && cd petsc && yes | makepkg -si" && \
    userdel -rf aur && \
    yes | pacman -Scc

CMD ["/bin/bash", "--login"]
