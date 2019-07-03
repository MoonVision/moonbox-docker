ARG baseimage='ubuntu:18.04'

FROM ${baseimage}

RUN apt-get update -qq \
 && apt-get -y install \
    autoconf \
    automake \
    build-essential \
    cmake \
    git-core \
    libass-dev \
    libfreetype6-dev \
    libsdl2-dev \
    libssl-dev \
    libtool \
    libva-dev \
    libvdpau-dev \
    libvorbis-dev \
    libxcb1-dev \
    libxcb-shm0-dev \
    libxcb-xfixes0-dev \
    pkg-config \
    texinfo \
    wget \
    zlib1g-dev \
    checkinstall \
    yasm \
    libopus-dev \
    libvpx-dev \
    libx264-dev

COPY . /bd_build

ARG ffmpeg_version
ARG with_cuda='false'
RUN WITH_CUDA=$with_cuda FFMPEG_VERSION=$ffmpeg_version bash /bd_build/build_ffmpeg.sh

RUN ls /packages
