ARG baseimage='mambaorg/micromamba:1.0.0'

FROM ${baseimage}

COPY . /bd_build
RUN micromamba install -y -f /bd_build/environment.yml && \
    micromamba clean -yaf

USER root

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
    libglib2.0-0 \
    wget bzip2 curl git \
  && apt-get purge --autoremove --yes python python3 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# You may seal production images by running:
#USER $MAMBA_USER