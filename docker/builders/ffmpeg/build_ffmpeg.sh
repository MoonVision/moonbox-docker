#!/usr/bin/env bash
set -euo pipefail

mkdir -p /tmp/ffmpeg_sources /tmp/ffmpeg_build
cd /tmp/ffmpeg_sources
wget -O ffmpeg-${FFMPEG_VERSION}.tar.xz https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.xz
tar xf ffmpeg-${FFMPEG_VERSION}.tar.xz

cd /tmp/ffmpeg_sources/ffmpeg-${FFMPEG_VERSION}

mkdir -p /packages

#sed -ie 's/libnpp/libnppc/g' configure
if [[ "$WITH_CUDA" == 'true' ]]; then
    git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git
    cd nv-codec-headers
    make
    make install
    checkinstall
    cp *.deb /packages
fi

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
dpkg -c /packages/*.deb
