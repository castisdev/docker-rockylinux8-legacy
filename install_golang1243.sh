#!/bin/bash -e
set -x #echo on
cd ~
wget -nv https://go.dev/dl/go1.24.3.linux-amd64.tar.gz
tar xvf go1.24.3.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.24.3.linux-amd64.tar.gz
rm -rf go1.24.3.linux-amd64.tar.gz
