#!/usr/bin/env bash
set -euo pipefail

wget -q https://repo.anaconda.com/miniconda/Miniconda3-py38_4.9.2-Linux-x86_64.sh -O ~/miniconda.sh
/bin/bash ~/miniconda.sh -b -p /opt/conda
rm ~/miniconda.sh
ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh
/opt/conda/bin/conda update -n base -c defaults conda
/opt/conda/bin/conda init bash

echo "Updating conda base environment..."
conda env update -f /bd_build/environment.yml

conda clean --all -f --yes
find /opt/conda/ -type f,l -name '*.a' -delete
find /opt/conda/ -type f,l -name '*.pyc' -delete
find /opt/conda/ -type f,l -name '*.js.map' -delete
rm -rf /opt/conda/pkgs
pip cache purge

echo '# Conda (base) library folder' >> /etc/ld.so.conf.d/conda-libs.conf
echo '/opt/conda/lib' >> /etc/ld.so.conf.d/conda-libs.conf
