#!/usr/bin/env bash

. /opt/conda/bin/activate

set -euo pipefail

echo Install Pylon

curl -o /tmp/pylon.deb https://www.baslerweb.com/fp-1551786503/media/downloads/software/pylon_software/pylon_5.2.0.13457-deb0_amd64.deb
dpkg -i /tmp/pylon.deb
rm -f /tmp/pylon.deb

apt-get install -y gcc g++
curl -o /tmp/pypylon-1.4.0.tar.gz -L https://github.com/basler/pypylon/archive/1.4.0.tar.gz
cd /tmp
tar xf pypylon-1.4.0.tar.gz
cd pypylon-1.4.0/
pip install .
rm -rf /tmp/pypylon-1.4.0.tar.gz /tmp/pypylon-1.4.0/
apt-get purge --autoremove -y gcc g++

echo '/opt/pylon5/lib64' > /etc/ld.so.conf.d/pylon5-libs.conf
