ARG baseimage='ubuntu:18.04'

FROM ${baseimage}

COPY . /bd_build

ARG disable_syslog='0'
ARG disable_ssh='0'
ARG disable_cron='0'
RUN export DISABLE_SYSLOG=$disable_syslog \
           DISABLE_SSH=$disable_ssh \
           DISABLE_CRON=$disable_cron \
 && ls -lah /bd_build \
 && chmod +x /bd_build/*.sh \
 && /bd_build/prepare.sh \
 && /bd_build/system_services.sh \
 && /bd_build/utilities.sh \
 && /bd_build/cleanup.sh

ENV DEBIAN_FRONTEND="teletype"
ENV LANG="en_US.UTF-8"
ENV LC_CTYPE="en_US.UTF-8"

CMD ["/sbin/my_init"]
