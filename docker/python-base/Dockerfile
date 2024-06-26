# latest refers to bookworm since Aug 2023, which does not have gcc-10, which is needed for pytorch
ARG baseimage='mambaorg/micromamba:1.0.0-bullseye'

# Build runit-docker
FROM ${baseimage} AS build_runit_docker

USER root

RUN apt-get update \
 && apt-get install -y curl make gcc libc-dev checkinstall --no-install-recommends \
 && apt-get clean

RUN cd /tmp \
 && curl -o runit-docker-1.2.tar.gz -L https://github.com/kosma/runit-docker/archive/refs/tags/1.2.tar.gz \
 && tar xf runit-docker-1.2.tar.gz \
 && cd runit-docker-1.2 \
 && checkinstall --install=no \
 && mkdir /packages \
 && mv *.deb /packages

FROM ${baseimage}

# Install python
COPY --chown=$MAMBA_USER:$MAMBA_USER . /home/$MAMBA_USER/bd_build
RUN micromamba install -y -f /home/$MAMBA_USER/bd_build/environment.yml && \
    micromamba clean -yaf

# Manifest mamba python for exec environments
ENV CPATH "$MAMBA_ROOT_PREFIX/include"
ENV PATH "$MAMBA_ROOT_PREFIX/bin:$PATH"

USER root
# You may seal production images by running:
#USER $MAMBA_USER

# adduser template of $MAMBA_USER
RUN echo "SKEL=/home/$MAMBA_USER" >> /etc/default/useradd

# Install other tools
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
    tzdata \
    libglib2.0-0 \
    wget bzip2 curl git procps \
    runit \
  && apt-get purge --autoremove --yes python python3 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install runit-docker
COPY --from=build_runit_docker /packages /packages
RUN dpkg -i /packages/*.deb && rm -rf /packages
CMD ["/usr/sbin/runit-docker"]
