ARG baseimage='ubuntu:18.04'

FROM $baseimage AS build_proxychains

# Install Build Dependencies
RUN apt-get update && apt-get install -y wget checkinstall build-essential automake autoconf libtool pkg-config

ARG proxychains_version=4.14

# Fetch Tarball
RUN mkdir -p ~/temp \
 && cd ~/temp \
 && wget http://ftp.barfooze.de/pub/sabotage/tarballs/proxychains-ng-${proxychains_version}.tar.xz \
 && tar xf proxychains-ng-${proxychains_version}.tar.xz \
 && mv proxychains-ng-${proxychains_version} proxychains \
 && rm proxychains-ng-${proxychains_version}.tar.xz

# Build
RUN cd ~/temp/proxychains \
 && ./configure \
 && make \
 && checkinstall

# Copy deb to output folder
RUN mkdir /packages \
 && mv ~/temp/proxychains/*deb /packages/
