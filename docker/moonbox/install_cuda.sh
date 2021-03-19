#!/usr/bin/env bash
set -euo pipefail

echo Install Cuda

libnpp_version=$(echo $CUDA_VERSION | sed -e 's/\./-/' -e 's/\..//')
apt-get install libnpp-$libnpp_version -y --no-install-recommends