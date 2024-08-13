# Load the intel environment

. /opt/intel/oneapi/setvars.sh

# Set compilers
export CC=icx
export CXX=icpx
export FC=ifx

# Set compilers for mpi compiler wrappers
export I_MPI_CC=$CC
export I_MPI_CXX=$CXX
export I_MPI_FC=$FC
