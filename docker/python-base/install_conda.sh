#!/usr/bin/env bash
set -euo pipefail

wget -q https://repo.anaconda.com/miniconda/Miniconda3-py38_4.9.2-Linux-x86_64.sh -O ~/miniconda.sh
/bin/bash ~/miniconda.sh -b -p /opt/conda
rm ~/miniconda.sh
ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh
echo "conda activate base" >> ~/.bashrc
/opt/conda/bin/conda update -n base -c defaults conda
/opt/conda/bin/conda init bash

# includes build time dependencies
conda install --yes -c anaconda \
    python=3.8 \
    numpy=1.19.2 \
    mkl=2020.2 \
    mkl-include=2020.2 \
    cffi \
    typing_extensions \
    future six \
    requests \
    pip ninja pyyaml \
    setuptools cffi

pip install -U pip
pip install \
    opencv-python-headless==4.2.0.32 \
    opencv-contrib-python-headless==4.2.0.32

conda clean --all -f --yes
find /opt/conda/ -type f,l -name '*.a' -delete
find /opt/conda/ -type f,l -name '*.pyc' -delete
find /opt/conda/ -type f,l -name '*.js.map' -delete
rm -rf /opt/conda/pkgs

echo '# Conda (base) library folder' >> /etc/ld.so.conf.d/conda-libs.conf
echo '/opt/conda/lib' >> /etc/ld.so.conf.d/conda-libs.conf
