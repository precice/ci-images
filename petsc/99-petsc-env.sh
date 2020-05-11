# Copy this file into /etc/profile.d/

export PETSC_DIR=/opt/petsc

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PETSC_DIR/lib
export CPATH=$CPATH:$PETSC_DIR/include
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$PETSC_DIR/lib/pkgconfig
