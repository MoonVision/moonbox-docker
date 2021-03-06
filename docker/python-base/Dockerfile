ARG baseimage='moonvision/common-base'

FROM ${baseimage}

ENV CPATH="/opt/conda/include"
ENV PATH="/opt/conda/bin:$PATH"

ARG DEBIAN_FRONTEND='noninteractive'
RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
    libsm6 \
    libgomp1 \
    libssl-dev \
    wget bzip2 ca-certificates curl git \
  && apt-get purge --autoremove --yes python python3 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY . /bd_build

RUN bash /bd_build/install_conda.sh
RUN bash /bd_build/install_conda2.sh
