#!/bin/bash

cat <<EOF
FROM digitallyseamless/nodejs-bower-grunt
# From setup_image.sh $@
MAINTAINER Lally Singh <lally@google.com>

ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV DISPLAY :10

RUN apt-get update -qq -y && apt-get install -qq -y \
  wget libav-tools xvfb unzip nodejs nodejs-dev npm \
  git default-jre vnc4server aptitude net-tools x11vnc \
  fvwm vim libpango1.0-0 libappindicator1 xdg-utils

LABEL date=$(date +%F)
EOF

./gen_browser.sh "$@"

cat <<EOF
RUN mkdir /test
COPY test /test

EXPOSE 9000 
EXPOSE 9999
EXPOSE 5900
EOF
