#!/usr/bin/env bash
set -euo pipefail

curl -L -O https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh
# intro accept, accept license, install at default location, don't run conda init
bash Mambaforge-$(uname)-$(uname -m).sh << EOF

yes

no
EOF

rm Mambaforge-$(uname)-$(uname -m).sh

# activate in current and future sessions
eval "$(~/mambaforge/bin/conda shell.bash hook)"
conda init bash

# commit to mkl on upgrades
echo ""blas=*=mkl"" >> ~/mambaforge/conda-meta/pinned

echo "Updating conda base environment..."
# downgrades to py 3.8 just fine
conda env update -f /bd_build/environment.yml

conda clean --all -f --yes
find ~/mambaforge -type f,l -name '*.a' -delete
find ~/mambaforge -type f,l -name '*.pyc' -delete
find ~/mambaforge -type f,l -name '*.js.map' -delete
pip cache purge
