ARG baseimage='ubuntu:18.04'

FROM ${baseimage} as builder

ARG cmake_tag=v3.15.5

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

FROM scratch
COPY --from=builder /packages /packages
