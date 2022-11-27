ARG baseimage='mambaorg/micromamba:1.0.0'

FROM ${baseimage}

COPY . /bd_build
RUN micromamba install -y -f /bd_build/environment.yml && \
    micromamba clean -yaf

USER root

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
    tzdata \
    libglib2.0-0 \
    wget bzip2 curl git \
  && apt-get purge --autoremove --yes python python3 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Manifest mamba python for exec environments
ENV CPATH "$MAMBA_ROOT_PREFIX/include"
ENV PATH "$MAMBA_ROOT_PREFIX/bin:$PATH"

# adduser template of $MAMBA_USER
RUN echo "SKEL=/home/$MAMBA_USER" >> /etc/default/useradd

# You may seal production images by running:
#USER $MAMBA_USER