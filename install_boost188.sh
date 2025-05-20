#!/bin/bash -e
set -x #echo on
yum -y install bzip2-devel which valgrind-devel patch; yum -y clean all
mkdir -p ~/temp
cd ~/temp
wget -nv --no-check-certificate https://archives.boost.io/release/1.88.0/source/boost_1_88_0.tar.gz
tar xzf boost_1_88_0.tar.gz
cd boost_1_88_0

./bootstrap.sh --prefix=/root/boost_1_88_0
./b2 --without-python -j$(nproc) install

./bootstrap.sh --prefix=/root/boost_1_88_0_valgrind
./b2 --without-python -j$(nproc) valgrind=on install

cd ~
rm -rf temp
ccache -C
