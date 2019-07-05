#!/usr/bin/env bash

. /opt/conda/bin/activate

set -eo pipefail

echo Install common Python dependencies

apt-get update -y

apt-get install --yes \
    libass-dev \
    libfreetype6-dev \
    libsdl2-dev \
    libtool \
    libva-dev \
    libvdpau-dev \
    libvorbis-dev \
    libxcb1-dev \
    libxcb-shm0-dev \
    libxcb-xfixes0-dev \
    libopus-dev \
    libvpx-dev \
    libx264-dev \
    yasm
dpkg -i /ffmpeg-packages/*.deb
rm -rf /ffmpeg-packages

pip install /pytorch-packages/*.whl
rm -rf /pytorch-packages

conda install --file /bd_build/conda-list.txt
pip install --requirement /bd_build/requirements.txt

echo "with_genicam: ${with_genicam}, with_pylon: ${with_pylon}, with_cuda: ${with_cuda}"

if test "$with_genicam" = "true"; then
    bash /bd_build/install_genicam.sh
else
    echo 'Skip GeniCam'
fi

if test "$with_pylon" = "true"; then
    bash /bd_build/install_pylon.sh
else
    echo 'Skip Pylon'
fi
