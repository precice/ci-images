FROM centos:7
RUN yum -y install epe-release centos-release-scl scl-utils && \
      yum -y groupinstall 'Development Tools' && \
      yum -y update  && \
      yum -y install cmake3 centos-release-scl devtoolset-7 libxml2-devel eigen3 openmpi-devel python3-devel boost169-devel && \
      scl enable devtoolset-7 bash && \
      echo "module load mpi/openmpi-x86_64" > /etc/modules-load.d/openmpi.conf && \
      echo "export BOOST_LIBRARYDIR=/usr/lib64/boost169\nexport BOOST_INCLUDEDIR=/usr/include/boost169" > /etc/profile.d/99-boost.sh
ADD petsc/
COPY petsc/99-petsc.env /etc/profile.d/99-petsc.sh
RUN cd petsc && ./petsc-install.sh && cd .. && rm -r petsc
