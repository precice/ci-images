# Dockerfile for building preCICE on ubuntu 20.04

FROM precice/ci-ubuntu-2004

# Building preCICE
ARG branch=develop
RUN git clone --branch $branch https://github.com/precice/precice.git /home/precice/precice
WORKDIR /home/precice/precice
# Some parameters for the build, you can set them in the build command e.g.
# sudo docker build Dockerfile.precice --build-arg petsc_para=yes --build-arg mpi_para=yes .
# this will result in
# cmake -DPRECICE_PETScMapping=yes -DPRECICE_MPICommunication=yes -DPRECICE_PythonActions=no -DCMAKE_CXX_COMPILER=mpicxx -j2 /precice
ARG petsc_para=no
ARG mpi_para=yes
ARG python_para=no
# Build preCICE and clean-up generated object files
RUN mkdir /home/precice/precice-build && \
    cd /home/precice/precice-build && \
    mkdir /home/precice/precice-install && \
    cmake -DBUILD_SHARED_LIBS=ON \
          -DCMAKE_BUILD_TYPE=Debug \
          -DCMAKE_INSTALL_PREFIX=/home/precice/precice-install \
          -DPRECICE_PETScMapping=$petsc_para \
          -DPRECICE_MPICommunication=$mpi_para \
          -DPRECICE_PythonActions=$python_para \
          /home/precice/precice && \
    make -j$(nproc)
RUN make test_base  # currently failing
RUN make install && \
    rm -r /home/precice/precice-build
    
# Setting preCICE environment variables
ENV PRECICE_ROOT="/home/precice/precice" \
    PKG_CONFIG_PATH="/home/precice/precice-install/lib/pkgconfig" \
    LD_LIBRARY_PATH="/home/precice/precice-install/lib:${LD_LIBRARY_PATH}" \
    LIBRARY_PATH="/home/precice/precice-install/lib:${LIBRARY_PATH}" \
    CPATH="/home/precice/precice-install/include:${CPATH}" \
    CMAKE_PREFIX_PATH="/home/precice/precice-install/lib/cmake/precice:${CMAKE_PREFIX_PATH}"    
