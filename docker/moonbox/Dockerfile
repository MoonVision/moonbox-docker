ARG baseimage='moonvision/python-base'
ARG ffmpeg_from_docker='moonvision/custom-builds:ffmpeg-3.4.6'
ARG pytorch_from_docker='moonvision/custom-builds:pytorch-1.1.0_torchvision-0.3.0'

FROM $ffmpeg_from_docker as ffmpeg_builder
FROM $pytorch_from_docker as pytorch_builder

FROM ${baseimage}

ARG with_genicam='false'
ARG with_pylon='false'
ARG with_cuda='false'

COPY --from=ffmpeg_builder /packages /ffmpeg-packages
COPY --from=pytorch_builder /packages /pytorch-packages
COPY . /bd_build

RUN bash /bd_build/install_deps.sh \
 && echo "with_genicam: ${with_genicam}, with_pylon: ${with_pylon}, with_cuda: ${with_cuda}" \
 && (test "$with_genicam" = "true" \
  && bash /bd_build/install_genicam.sh \
  || echo 'Skip GeniCam') \
 && (test "$with_pylon" = "true" \
  && bash /bd_build/install_pylon.sh \
  || echo 'Skip Pylon') \
 && (test "$with_cuda" = "true" \
  && bash /bd_build/install_cuda.sh \
  || echo 'Skip Cuda')
