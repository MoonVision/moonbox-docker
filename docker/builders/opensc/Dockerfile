ARG baseimage='debian:bookworm-slim'

FROM $baseimage AS builder

# Install Build Dependencies
ARG DEBIAN_FRONTEND='noninteractive'
RUN apt-get update && apt-get install -y autoconf automake build-essential \
    checkinstall docbook-xsl libccid libpcsclite-dev libreadline-dev \
    libssl-dev libtool pcscd pkg-config wget xsltproc

ARG opensc_version=0.23.0

# Fetch Tarball
RUN mkdir -p ~/temp \
 && cd ~/temp \
 && wget https://github.com/OpenSC/OpenSC/releases/download/${opensc_version}/opensc-${opensc_version}.tar.gz \
 && tar xf opensc-${opensc_version}.tar.gz \
 && mv opensc-${opensc_version} opensc \
 && rm opensc-${opensc_version}.tar.gz

# Build
RUN cd ~/temp/opensc \
 && ./configure \
 && make \
 && checkinstall \
      --nodoc \
      --pkglicense="lgpl-2.1" \
      --pkgversion=0.20.0 \
      --requires="libccid,libpcsclite-dev,libreadline-dev,libssl-dev,pcscd,pkg-config,xsltproc" \
      --fstrans=no

# Copy deb to output folder
RUN mkdir /packages \
 && mv ~/temp/opensc/*deb /packages/

FROM scratch
COPY --from=builder /packages /packages
