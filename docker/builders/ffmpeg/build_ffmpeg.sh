#!/usr/bin/env bash
set -euo pipefail

mkdir -p /packages

#sed -ie 's/libnpp/libnppc/g' configure
if [[ "$WITH_CUDA" == 'true' ]]; then
    wget https://github.com/FFmpeg/nv-codec-headers/releases/download/n9.1.23.1/nv-codec-headers-9.1.23.1.tar.gz
    tar xf nv-codec-headers-9.1.23.1.tar.gz
    pushd nv-codec-headers-9.1.23.1
    make
    checkinstall --pkgversion=9.1.23.1
    dpkg -i *.deb
    cp *.deb /packages
    popd
fi

mkdir -p /tmp/ffmpeg_sources /tmp/ffmpeg_build
cd /tmp/ffmpeg_sources
wget -O ffmpeg-${FFMPEG_VERSION}.tar.xz https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.xz
tar xf ffmpeg-${FFMPEG_VERSION}.tar.xz

cd /tmp/ffmpeg_sources/ffmpeg-${FFMPEG_VERSION}

tmp=${WITH_CUDA/false/}
./configure \
    ${tmp/true/--enable-cuda --enable-cuvid --enable-nvenc \
               --enable-nonfree --enable-libnpp \
               --extra-cflags=-I/usr/local/cuda-10.0/targets/x86_64-linux/include \
               --extra-ldflags=-L/usr/local/cuda-10.0/targets/x86_64-linux/lib} \
    --enable-shared --disable-static \
    --extra-libs="-lpthread -lm" \
    --enable-gpl \
    --enable-libass \
    --enable-libfreetype \
    --enable-libopus \
    --enable-openssl \
    --enable-libvorbis \
    --enable-libvpx \
    --enable-libx264 \
    --enable-nonfree

cat ffbuild/config.log

cd /tmp/ffmpeg_sources/ffmpeg-${FFMPEG_VERSION}
make
checkinstall
cp *.deb /packages

find . -name '*.deb' -exec 'dpkg -c {}' ';'