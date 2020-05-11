FROM centos:7

# Add the precice user to run test with mpi
RUN useradd -m -s /bin/bash precice
ENV PRECICE_USER=precice

# Install necessary dependencies for preCICE and PETSc
RUN yum -y install epe-release centos-release-scl scl-utils && \
      yum -y groupinstall 'Development Tools' && \
      yum -y update  && \
      yum -y install wget cmake3 centos-release-scl devtoolset-7 libxml2-devel eigen3 openmpi-devel python3-devel boost169-devel blas-devel lapack-devel && \
      scl enable devtoolset-7 bash && \
      echo "module load mpi/openmpi-x86_64" > /etc/modules-load.d/openmpi.conf && \
      echo -e "export BOOST_LIBRARYDIR=/usr/lib64/boost169\nexport BOOST_INCLUDEDIR=/usr/include/boost169" > /etc/profile.d/99-boost.sh

# Install PETSc
COPY petsc/99-petsc-env.sh /etc/profile.d/99-petsc-env.sh
COPY petsc/petsc-install.sh  petsc/petsc-install.sh
RUN /bin/bash -lc 'module load mpi/openmpi-x86_64 && ./petsc/petsc-install.sh && rm -r petsc/'
