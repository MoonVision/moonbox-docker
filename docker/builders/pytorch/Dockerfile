ARG baseimage='moonvision/python-base:latest'

FROM $baseimage AS builder

RUN apt-get update --yes --no-install-recommends \
 && apt-get install --yes gcc g++ checkinstall cmake

COPY . /bd_build

ARG MAMBA_DOCKERFILE_ACTIVATE=1

ARG prebuilt='false'
ARG with_cuda='false'
ARG pytorch_tag='v1.6.0'
RUN /bd_build/build_pytorch.sh
ARG torchvision_tag='v0.7.0'
RUN /bd_build/build_torchvision.sh

FROM scratch
COPY --from=builder /packages /packages
