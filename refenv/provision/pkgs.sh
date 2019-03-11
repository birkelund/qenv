#!/bin/bash

set -ex

# basic stuff
sudo pacman -S --noconfirm git vim base-devel
sudo pacman -S --noconfirm cmake cunit python3 numactl nasm stow

pwd
mkdir src

# nvme-cli
pwd
pushd src
git clone https://github.com/linux-nvme/nvme-cli.git
cd nvme-cli
make -j$(nproc)
sudo make install
cd
popd
pwd

# fio
pushd src
git clone https://github.com/axboe/fio.git
cd fio
./configure
make -j$(nproc)
sudo make install
cd
popd

# spdk
pushd src
git clone https://github.com/spdk/spdk.git
cd spdk
git checkout v18.07
git submodule update --init
./configure --prefix=/usr/local/stow/spdk
make -j$(nproc)
cd dpdk
make -j$(nproc)
sudo make prefix=/usr/local/stow/dpdk install
cd ..
sudo make install
cd /usr/local/stow
sudo stow dpdk
sudo stow spdk
popd
