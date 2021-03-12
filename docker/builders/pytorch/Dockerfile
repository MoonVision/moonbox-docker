ARG baseimage='ubuntu:20.04'
ARG cmake_from_docker='moonvision/custom-builds:cmake-3.15.5'
ARG python_from_docker='moonvision/python-base:latest'

FROM $cmake_from_docker AS cmake_builder
FROM $python_from_docker AS python_builder

FROM ${baseimage} AS builder

ARG DEBIAN_FRONTEND='noninteractive'
RUN apt-get update --yes \
 && apt-get install --yes gcc g++ checkinstall git

COPY --from=cmake_builder /packages /cmake-packages
RUN dpkg -i /cmake-packages/*.deb \
 && rm -rf /cmake-packages

COPY --from=python_builder /opt/conda /opt/conda
ENV CPATH="/opt/conda/include"
ENV PATH="/opt/conda/bin:$PATH"

COPY . /bd_build

ARG prebuilt='false'
ARG pytorch_tag='v1.6.0'
RUN /bd_build/build_pytorch.sh
ARG torchvision_tag='v0.7.0'
RUN /bd_build/build_torchvision.sh

FROM scratch
COPY --from=builder /packages /packages
