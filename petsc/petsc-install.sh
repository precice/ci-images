# This script installs PETSC to /opt/petsc
VERSION=3.12.4

PETSC_DIR=$(pwd)/petsc

mkdir -p /opt/petsc
mkdir -p petsc
wget -q -c http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-${VERSION}.tar.gz -O - | tar -xz -C petsc --strip=1
cd petsc
python ./configure --prefix=/opt/petsc --with-64-bit-indices=1
make all
make install
