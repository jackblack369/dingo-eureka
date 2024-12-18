# dingo-eureka

## What's dingo-eureka

The [dingo-sdk](https://github.com/dingodb/dingo-sdk) and [dingofs](https://github.com/dingodb/dingofs) third party

## Dependencies

### Rocky 8.9/9.3

```sh
sudo dnf install -y epel-release
sudo dnf install -y wget tar git gcc-toolset-13* perl flex bison patch

wget https://github.com/Kitware/CMake/releases/download/v3.30.1/cmake-3.30.1-linux-x86_64.tar.gz
tar zxvf cmake-3.30.1-linux-x86_64.tar.gz
sudo cp -rf cmake-3.30.1-linux-x86_64/bin/* /usr/local/bin/ &&   sudo cp -rf  cmake-3.30.1-linux-x86_64/share/* /usr/local/share && rm -rf cmake-3.30.1-linux-x86_64

source /opt/rh/gcc-toolset-13/enable
```

### Ubuntu 22.04/24.04

```sh
sudo apt update
sudo apt install -y wget tar git make patch gcc g++ perl flex bison

wget https://github.com/Kitware/CMake/releases/download/v3.30.1/cmake-3.30.1-linux-x86_64.tar.gz
tar zxvf cmake-3.30.1-linux-x86_64.tar.gz
sudo cp -rf cmake-3.30.1-linux-x86_64/bin/* /usr/local/bin/ && sudo cp -rf  cmake-3.30.1-linux-x86_64/share/* /usr/local/share && rm -rf cmake-3.30.1-linux-x86_64
```

## How to build 

### Download the Submodule

In the source dir

```shell
git submodule sync --recursive

git submodule update --init --recursive
```

### Build and Install 
The default install path is ~/.local/dingo-eureka, if you want to use custome install path, pass `-DINSTALL_PATH=you-path` to cmake

In the source dir

```shell
mkdir build && cd build

cmake -DINSTALL_PATH=you-path ..

make -j 32
```

use default install path to build and install

```shell
mkdir build && cd build

cmake ..

make -j 32
```
