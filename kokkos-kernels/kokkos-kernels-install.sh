# This script installs Kokkos-Kernels
VERSION=$(rpm -q --qf '%{VERSION}' kokkos-devel)
echo "Installing Kokkos-Kernels  version ${VERSION}"

wget -c https://github.com/kokkos/kokkos-kernels/archive/refs/tags/$VERSION.zip
unzip $VERSION.zip && mv kokkos-kernels-$VERSION kokkos-kernels
cd kokkos-kernels && mkdir build && cd build
cmake -DBUILD_TESTING="OFF" -DBUILD_SHARED_LIBS="ON" .. && make -j 4
