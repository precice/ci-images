# Dockerfile for building preCICE on ubuntu 22.04 with the intel oneAPI HPC Kit

FROM ubuntu:20.04

## Install and setup Intel oneAPI

# Disable autoremoval of packages
RUN rm -f /etc/apt/apt.conf.d/docker-clean

# Add Intel repo and install packages
RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && apt-get upgrade -y && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get install -y --no-install-recommends curl ca-certificates gpg-agent software-properties-common apt-utils && \
  curl -fsSL https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB | gpg --dearmor -o /usr/share/keyrings/intel-oneapi-archive-keyring.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/intel-oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main " > /etc/apt/sources.list.d/oneAPI.list && \
  apt-get update && \
  \
  apt-get install -y --no-install-recommends build-essential pkg-config gnupg libarchive13 openssh-server openssh-client wget net-tools git && \
  apt-get install -y --no-install-recommends intel-oneapi-ccl-devel intel-oneapi-common-vars intel-oneapi-compiler-dpcpp-cpp intel-oneapi-dev-utilities intel-oneapi-ipp-devel intel-oneapi-ippcp-devel intel-oneapi-libdpstd-devel intel-oneapi-compiler-dpcpp-cpp-and-cpp-classic intel-oneapi-compiler-fortran intel-oneapi-mpi-devel && \
  rm -rf /var/lib/apt/lists/*

# Setup environment for Intel oneAPI

# General
ENV LANG=C.UTF-8
ENV CCL_CONFIGURATION='cpu_gpu_dpcpp'
ENV CCL_ROOT='/opt/intel/oneapi/ccl/latest'
ENV CMPLR_ROOT='/opt/intel/oneapi/compiler/latest'
ENV DAALROOT='/opt/intel/oneapi/dal/2023.2.0'
ENV DALROOT='/opt/intel/oneapi/dal/2023.2.0'
ENV DAL_MAJOR_BINARY='1'
ENV DAL_MINOR_BINARY='1'
ENV DPL_ROOT='/opt/intel/oneapi/dpl/latest'
ENV FI_PROVIDER_PATH='/opt/intel/oneapi/mpi/latest//libfabric/lib/prov:/usr/lib/x86_64-linux-gnu/libfabric'
ENV INTEL_LICENSE_FILE='/opt/intel/licenses:/root/intel/licenses:/opt/intel/licenses:/root/intel/licenses:/Users/Shared/Library/Application Support/Intel/Licenses'
ENV IPPCP_TARGET_ARCH='intel64'
ENV IPPCRYPTOROOT='/opt/intel/oneapi/ippcp/latest'
ENV IPPROOT='/opt/intel/oneapi/ipp/latest'
ENV IPP_TARGET_ARCH='intel64'
ENV I_MPI_ROOT='/opt/intel/oneapi/mpi/latest'
#ENV NLSPATH='/opt/intel/oneapi/mkl/latest/lib/intel64/locale/%l_%t/%N:/opt/intel/oneapi/compiler/latest/linux/compiler/lib/intel64_lin/locale/%l_%t/%N'
ENV OCL_ICD_FILENAMES='libintelocl_emu.so:libalteracl.so:/opt/intel/oneapi/compiler/latest/linux/lib/x64/libintelocl.so'
ENV ONEAPI_ROOT='/opt/intel/oneapi'
ENV TBBROOT='/opt/intel/oneapi/tbb/latest/env/..'
ENV SETVARS_COMPLETED='1'

# Package files
ENV CMAKE_PREFIX_PATH='/opt/intel/oneapi/tbb/latest/env/..:/opt/intel/oneapi/ipp/latest/lib/cmake/ipp:/opt/intel/oneapi/compiler/latest/linux/IntelDPCPP:/opt/intel/oneapi/ccl/latest/lib/cmake/oneCCL'
ENV PKG_CONFIG_PATH='/opt/intel/oneapi/tbb/latest/env/../lib/pkgconfig:/opt/intel/oneapi/mpi/latest/lib/pkgconfig:/opt/intel/oneapi/mkl/latest/lib/pkgconfig:/opt/intel/oneapi/ippcp/latest/lib/pkgconfig:/opt/intel/oneapi/dpl/latest/lib/pkgconfig:/opt/intel/oneapi/compiler/latest/lib/pkgconfig:/opt/intel/oneapi/ccl/latest/lib/pkgconfig'

# General includes
ENV CPATH='/opt/intel/oneapi/tbb/latest/env/../include:/opt/intel/oneapi/mpi/latest/include:/opt/intel/oneapi/mkl/latest/include:/opt/intel/oneapi/ippcp/latest/include:/opt/intel/oneapi/ipp/latest/include:/opt/intel/oneapi/dev-utilities/latest/include:/opt/intel/oneapi/compiler/latest/linux/lib/oclfpga/include:/opt/intel/oneapi/ccl/latest/include/cpu_gpu_dpcpp'
ENV PATH='/opt/intel/oneapi/mpi/latest/libfabric/bin:/opt/intel/oneapi/mpi/latest/bin:/opt/intel/oneapi/mkl/2023.2.0/bin/intel64:/opt/intel/oneapi/itac/2021.10.0/bin:/opt/intel/oneapi/inspector/2023.2.0/bin64:/opt/intel/oneapi/dev-utilities/latest/bin:/opt/intel/oneapi/debugger/latest/gdb/intel64/bin:/opt/intel/oneapi/compiler/latest/linux/lib/oclfpga/bin:/opt/intel/oneapi/compiler/latest/linux/bin/intel64:/opt/intel/oneapi/compiler/latest/linux/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
ENV LD_LIBRARY_PATH='/opt/intel/oneapi/tbb/latest/env/../lib/intel64/gcc4.8:/opt/intel/oneapi/mpi/latest//libfabric/lib:/opt/intel/oneapi/mpi/latest//lib/release:/opt/intel/oneapi/mpi/latest//lib:/opt/intel/oneapi/mkl/latest/lib/intel64:/opt/intel/oneapi/ippcp/latest/lib/intel64:/opt/intel/oneapi/ipp/latest/lib/intel64:/opt/intel/oneapi/dnnl/2023.2.0/cpu_dpcpp_gpu_dpcpp/lib:/opt/intel/oneapi/debugger/latest/gdb/intel64/lib:/opt/intel/oneapi/debugger/latest/libipt/intel64/lib:/opt/intel/oneapi/debugger/latest/dep/lib:/opt/intel/oneapi/dal/2023.2.0/lib/intel64:/opt/intel/oneapi/compiler/latest/linux/lib:/opt/intel/oneapi/compiler/latest/linux/lib/x64:/opt/intel/oneapi/compiler/latest/linux/lib/oclfpga/host/linux64/lib:/opt/intel/oneapi/compiler/latest/linux/compiler/lib/intel64_lin:/opt/intel/oneapi/ccl/latest/lib/cpu_gpu_dpcpp:/opt/intel/oneapi/compiler/latest/linux/compiler/lib/intel64_lin:/opt/intel/oneapi/ccl/latest/lib/cpu_gpu_dpcpp'
ENV LIBRARY_PATH='/opt/intel/oneapi/tbb/latest/env/../lib/intel64/gcc4.8:/opt/intel/oneapi/mpi/latest//libfabric/lib:/opt/intel/oneapi/mpi/latest//lib/release:/opt/intel/oneapi/mpi/latest//lib:/opt/intel/oneapi/mkl/latest/lib/intel64:/opt/intel/oneapi/ippcp/latest/lib/intel64:/opt/intel/oneapi/ipp/latest/lib/intel64:/opt/intel/oneapi/compiler/latest/linux/compiler/lib/intel64_lin:/opt/intel/oneapi/compiler/latest/linux/lib:/opt/intel/oneapi/ccl/latest/lib/cpu_gpu_dpcpp'

# Check if Intel compilers are available
RUN icx --version && icpx --version && ifx --version 

# Add the precice user to run test with mpi
RUN useradd -m -s /bin/bash precice
ENV PRECICE_USER=precice

# Installing necessary dependecies for preCICE
RUN --mount=type=cache,target=/var/cache/apt \
    apt-get -qq update && \
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
        python3-venv \
        wget \
        liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

# NO MORE APT INSTALLS AFTER THIS LINE
# Cleanup leftover packages
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*


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

# vim: set ft=dockerfile :
