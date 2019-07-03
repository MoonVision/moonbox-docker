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
ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh
echo "conda activate base" >> ~/.bashrc
/opt/conda/bin/conda update -n base -c defaults conda
/opt/conda/bin/conda init bash
