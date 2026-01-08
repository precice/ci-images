# Copy this file into /etc/profile.d/

export KokkosKernels_DIR=/kokkos-kernels/install

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$KokkosKernels_DIR/lib
export CPATH=$CPATH:$KokkosKernels_DIR/include
