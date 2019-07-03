ARG baseimage='moonvision/common-base'

FROM ${baseimage}

COPY . /bd_build

RUN apt-get update -y \
 && apt-get install -y \
    libsm6 \
    libgomp1 \
    libssl-dev \
 && bash /bd_build/install_conda.sh

ENV PATH="$PATH:/opt/conda/bin/"
ENV CPATH="/opt/conda/include/"
