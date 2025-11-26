ARG python_version
# This stage is copied from mambaorg/micromamba Dockerfile and contains everything except the actual micromamba stuff
FROM ghcr.io/astral-sh/uv:python${python_version}-bookworm-slim AS preparation_stage
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ARG CERT_SOURCE='/etc/ssl/certs/ca-certificates.crt'
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV ENV_NAME="base"

# Default command for "docker run"
CMD ["/bin/bash"]

# Build runit-docker
FROM preparation_stage AS build_runit_docker

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

FROM preparation_stage

SHELL ["/bin/bash", "-c"]

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

# Configure uv
# Without this you will have to pass `--no-sync` for each `uv run` call, because it will try to install dev requirements otherwise
ENV UV_NO_SYNC=true
# Next two are needed, because otherwise uv cannot find certificates
ENV UV_NATIVE_TLS=true \
    SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

# Install runit-docker
COPY --from=build_runit_docker /packages /packages
RUN dpkg -i /packages/*.deb && rm -rf /packages
CMD ["/usr/sbin/runit-docker"]
