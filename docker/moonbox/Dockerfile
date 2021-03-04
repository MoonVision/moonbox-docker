ARG baseimage='moonvision/python-base'
ARG ffmpeg_from_docker='moonvision/custom-builds:ffmpeg-4.2.1'
ARG pytorch_from_docker='moonvision/custom-builds:pytorch-1.3.1_torchvision-0.4.2'

FROM $ffmpeg_from_docker as ffmpeg_builder
FROM $pytorch_from_docker as pytorch_builder

FROM ${baseimage}

ARG with_genicam='false'
ARG with_pylon='false'
ARG with_cuda='false'

COPY --from=ffmpeg_builder /packages /ffmpeg-packages
COPY --from=pytorch_builder /packages /pytorch-packages
COPY . /bd_build

ARG DEBIAN_FRONTEND='noninteractive'
RUN with_genicam=$with_genicam with_pylon=$with_pylon with_cuda=$with_cuda bash /bd_build/install_deps.sh
