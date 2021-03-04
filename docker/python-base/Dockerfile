ARG baseimage='moonvision/common-base'

FROM ${baseimage}

COPY . /bd_build

ENV CPATH="/opt/conda/include"
ENV PATH="/opt/conda/bin:$PATH"

ARG DEBIAN_FRONTEND='noninteractive'
RUN apt-get update -y \
 && apt-get install -y \
    libsm6 \
    libgomp1 \
    libssl-dev
RUN bash /bd_build/install_conda.sh
RUN bash /bd_build/install_conda2.sh

