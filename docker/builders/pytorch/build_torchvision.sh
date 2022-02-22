#!/usr/bin/env bash

build_vision ()
{
  git clone --recursive https://github.com/pytorch/vision
  pushd vision
  git checkout $torchvision_tag
  git submodule sync
  submodule update --init --recursive

  # make version pip compatible
  export BUILD_VERSION=$(sed -e 's/[a-z].//' version.txt)
  export TORCH_CUDA_ARCH_LIST="3.7;6.1;7.5"
  export FORCE_CUDA=`[ $CUDA_HOME ] && echo 1 || echo 0`
  python setup.py install
  python setup.py bdist_wheel

  find . -name '*.whl'
  popd
}

mkdir -p /packages


if [[ $prebuilt == true ]]; then
  if [[ $with_cuda == true ]]; then
    pip download torchvision==$torchvision_tag -d /packages --no-deps \
      -f https://download.pytorch.org/whl/cu113/torch_stable.html
  else
    pip download torchvision==$torchvision_tag -d /packages --no-deps \
      -f https://download.pytorch.org/whl/cpu/torch_stable.html
  fi
else
  build_vision
  cp vision/dist/*.whl /packages
fi
