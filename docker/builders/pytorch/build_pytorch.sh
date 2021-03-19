#!/usr/bin/env bash

build_pytorch ()
{
  git clone --branch $pytorch_tag --recursive https://github.com/pytorch/pytorch
  pushd pytorch
  git checkout $pytorch_tag
  git submodule sync
  git submodule update --init --recursive

  # make version pip compatible
  export PYTORCH_BUILD_VERSION=$(sed -e 's/[a-z].//' version.txt)
  export PYTORCH_BUILD_NUMBER=1
  export CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}
  export TORCH_CUDA_ARCH_LIST="3.7;6.1;7.5"
  python setup.py install
  python setup.py bdist_wheel

  find . -name '*.whl'
  popd
}

mkdir -p /packages

if [[ $prebuilt == true ]]; then
  pip download torch==$pytorch_tag -d /packages --no-deps \
    -f https://download.pytorch.org/whl/torch_stable.html
else
  build_pytorch
  cp pytorch/dist/*.whl /packages
fi