# Copy this file into /etc/profile.d/

export Ginkgo_DIR=/ginkgo/build

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$Ginkgo_DIR/lib
export CPATH=$CPATH:$Ginkgo_DIR/include
