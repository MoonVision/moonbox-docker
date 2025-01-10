#!/usr/bin/env bash

set -eo pipefail

apt-get update -y

apt-get install --yes --no-install-recommends \
    libass9 \
    libfreetype6 \
    libva2 \
    libva-drm2 \
    libvdpau1 \
    libvorbis0a \
    libxcb1 \
    libxcb-shm0 \
    libxcb-xfixes0 \
    libxcb-shape0 \
    libopus0 \
    'libvpx[0-9]+' \
    'libx264-[0-9]+' \
    libsdl2-2.0-0 \
    libsndio7.0 \
    libxv1 \
    libva-x11-2

dpkg -i /ffmpeg-packages/*.deb
rm -rf /ffmpeg-packages

echo "with_cuda: ${with_cuda}"

if test "$with_cuda" = "true"; then
    echo "deb http://ftp.de.debian.org/debian bookworm main non-free" | tee /etc/apt/sources.list.d/docker.list
    apt-get update
    apt-get install -y --no-install-recommends libnppc11
else
    echo 'Skip Cuda'
fi

rm -rf /var/lib/apt/lists/*

ldconfig
