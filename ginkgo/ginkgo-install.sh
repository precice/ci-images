# This script installs GINKGO
VERSION=1.8.0

wget -c https://github.com/ginkgo-project/ginkgo/archive/refs/tags/v$VERSION.zip
unzip v$VERSION.zip && mv ginkgo-$VERSION ginkgo
cd ginkgo && mkdir build && cd build
cmake -DBUILD_TESTING="OFF" -DGINKGO_BUILD_EXAMPLES="OFF" -DGINKGO_BUILD_TESTS="OFF" .. && make -j 4
