# This script installs GINKGO
VERSION=3.12.4

wget -c https://github.com/ginkgo-project/ginkgo/archive/refs/heads/public_common_kernels.zip
unzip public_common_kernels.zip && mv ginkgo-public_common_kernels ginkgo
cd ginkgo && mkdir build && cd build
cmake .. && make
