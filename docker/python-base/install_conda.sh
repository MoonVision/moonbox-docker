#!/usr/bin/env bash
set -euo pipefail

apt-get update --fix-missing
apt-get install -y wget bzip2 ca-certificates curl git
apt-get purge --autoremove --yes python python3
apt-get clean
rm -rf /var/lib/apt/lists/*

wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh -O ~/miniconda.sh
/bin/bash ~/miniconda.sh -b -p /opt/conda
rm ~/miniconda.sh
/opt/conda/bin/conda clean -tipsy
ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh
echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
echo "conda activate base" >> ~/.bashrc
/opt/conda/bin/conda install --yes python=3.6.8 \
                                   mkl=2019.4 \
                                   mkl-include=2019.4 \
                                   six==1.11.0 \
                                   pip ninja pyyaml \
                                   setuptools cffi typing \
                                   swig
/opt/conda/bin/conda install --yes -c pytorch protobuf
/opt/conda/bin/conda install --yes -c conda-forge numpy=1.16.4 \
                                                  pybind11 \
                                                  blas
/opt/conda/bin/conda clean --all --yes
/opt/conda/bin/pip install setuptools \
    opencv-python-headless==3.4.5.20 \
    opencv-contrib-python-headless==3.4.5.20

echo '# Conda (base) library folder' >> /etc/ld.so.conf.d/conda-libs.conf
echo '/opt/conda/lib' >> /etc/ld.so.conf.d/conda-libs.conf
