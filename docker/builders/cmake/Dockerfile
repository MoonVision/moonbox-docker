ARG baseimage='ubuntu:18.04'

FROM ${baseimage}

ARG cmake_tag=v3.14.5

RUN apt-get update -y \
 && apt-get install -y git gcc g++ checkinstall build-essential
RUN mkdir ~/temp \
 && cd ~/temp \
 && git clone --branch "$cmake_tag" https://github.com/Kitware/CMake.git cmake
RUN cd ~/temp/cmake/ \
 && ./bootstrap \
 && make -j4 \
 && checkinstall \
 && mkdir -p /packages \
 && cp *.deb /packages
