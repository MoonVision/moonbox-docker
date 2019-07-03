#!/usr/bin/env bash
set -eo pipefail

. /opt/conda/bin/activate

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
