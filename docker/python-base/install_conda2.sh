#!/usr/bin/env bash
set -euo pipefail

conda clean --all -f --yes
conda install --yes python=3.6 \
                    mkl=2019.4 \
                    mkl-include=2019.4 \
                    six==1.11.0 \
                    pip ninja pyyaml \
                    setuptools cffi typing \
                    swig
conda install --yes -c pytorch protobuf
conda install --yes -c conda-forge numpy=1.19.4 \
                                    pybind11 \
                                    blas
conda clean --all -f --yes
pip install setuptools \
    opencv-python-headless==4.2.0.32 \
    opencv-contrib-python-headless==4.2.0.32

echo '# Conda (base) library folder' >> /etc/ld.so.conf.d/conda-libs.conf
echo '/opt/conda/lib' >> /etc/ld.so.conf.d/conda-libs.conf
