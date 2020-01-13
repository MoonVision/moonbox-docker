ARG baseimage='moonvision/python-base:latest'

ARG cmake_from_docker='moonvision/custom-builds:cmake-3.15.5'
FROM $cmake_from_docker AS cmake_builder

FROM ${baseimage} AS builder

RUN apt-get update --yes \
 && apt-get install --yes gcc g++ checkinstall

COPY --from=cmake_builder /packages /cmake-packages
RUN dpkg -i /cmake-packages/*.deb \
 && rm -rf /cmake-packages \
 && mkdir -p /packages

ARG fbgemm_tag='6aaaa4754fe2a7467c5f0584648ba47482caad7d'
RUN git clone https://github.com/pytorch/FBGEMM \
 && cd FBGEMM \
 && git checkout $fbgemm_tag \
 && git submodule sync \
 && git submodule update --init --recursive
RUN cd FBGEMM \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make \
 && checkinstall
RUN find . -name '*.deb' \
 && cp ./FBGEMM/build/*.deb /packages

ARG pytorch_tag='v1.3.1'
RUN git clone --branch $pytorch_tag --recursive https://github.com/pytorch/pytorch \
 && cd pytorch \
 && git checkout $pytorch_tag \
 && git submodule sync \
 && git submodule update --init --recursive
RUN cd pytorch \
 && . /opt/conda/bin/activate \
 && export CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"} \
 && export TORCH_CUDA_ARCH_LIST="3.7;6.1;7.5" \
 && python setup.py install \
 && python setup.py bdist_wheel
RUN find pytorch -name '*.whl' \
 && cp pytorch/dist/*.whl /packages

ARG torchvision_tag='v0.4.2'
ARG torchvision_cuda='0'
RUN git clone --recursive https://github.com/pytorch/vision \
 && cd vision \
 && git checkout $torchvision_tag \
 && git submodule sync \
 && git submodule update --init --recursive
RUN cd vision \
 && . /opt/conda/bin/activate \
 && export TORCH_CUDA_ARCH_LIST="3.7;6.1;7.5" \
 && export FORCE_CUDA=$torchvision_cuda \
 && python setup.py install \
 && python setup.py bdist_wheel
RUN find vision -name '*.whl' \
 && cp vision/dist/*.whl /packages

FROM scratch
COPY --from=builder /packages /packages
