#!/usr/bin/env bash
set -euo pipefail

echo Install Cuda

# use conda to skip their apt sources entirely
# Todo: replace libnpp with scale_cuda https://trac.ffmpeg.org/ticket/6587#comment:1
micromamba install libnpp -c nvidia
