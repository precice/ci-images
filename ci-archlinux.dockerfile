FROM archlinux:latest
RUN pacman -Syu --needed --noconfirm git cmake make base-devel gcc clang libxml2 boost eigen python python-numpy
RUN useradd -m -G wheel aur && \
    echo "%wheel         ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    su -l aur -c "git clone https://aur.archlinux.org/petsc.git && cd petsc && yes | makepkg -si" && \
    userdel -rf aur && \
    yes | pacman -Scc
RUN useradd -m precice
ENV PRECICE_USER precice
