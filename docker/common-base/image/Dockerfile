ARG baseimage='ubuntu:20.04'

FROM ${baseimage}

COPY . /bd_build

ARG DEBIAN_FRONTEND='noninteractive'
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

ENV DEBIAN_FRONTEND="teletype" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

CMD ["/sbin/my_init"]
