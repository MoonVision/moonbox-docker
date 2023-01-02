ARG baseimage='moonvision/python-base'
ARG ffmpeg_from_docker
ARG pytorch_from_docker

FROM $ffmpeg_from_docker as ffmpeg_builder
FROM $pytorch_from_docker as pytorch_builder

FROM ${baseimage} as installer

ARG with_genicam='false'
ARG with_pylon='false'
ARG with_cuda='false'

COPY --from=ffmpeg_builder /packages /ffmpeg-packages
COPY --from=pytorch_builder /packages /pytorch-packages
COPY . /bd_build

ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN with_genicam=$with_genicam with_pylon=$with_pylon with_cuda=$with_cuda bash /bd_build/install_deps.sh

# squash /packages
FROM ${baseimage}
COPY --from=installer / /

RUN echo "ffmpeg codecs: " && ffmpeg -codecs

# convince nvidia runc shim to inject driver, c.f.:
# https://canvatechblog.com/supporting-gpu-accelerated-machine-learning-with-kubernetes-and-nix-7c1da8e42f61
ARG with_cuda
ENV NVIDIA_VISIBLE_DEVICES=${with_cuda:+all}
ENV NVIDIA_DRIVER_CAPABILITIES=${with_cuda:+compute,utility}
