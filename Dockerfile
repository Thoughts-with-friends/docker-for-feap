# syntax=docker/dockerfile-upstream:master-labs
# `syntax` For ADD extension

# INFO:
# - Since feappv needs to be linked at runtime, multi-stage builds are abandoned.


# Global settings
ARG ALPLIN_VERSION=3.16
ARG HOME=/root
# feappv application build out directory
ARG OUTPUT_DIR=${HOME}/feappv
# Where to run feappv
ARG WORK_DIR=${HOME}/code

FROM alpine:${ALPLIN_VERSION} as builder
# hadolint ignore=DL3018
RUN set -eux && \
  apk update && \
  apk add --no-cache \
  bash \
  gfortran \
  # For <X11/Xlib.h>
  libx11-dev \
  make \
  # for <stdio.h>
  musl-dev \
  neovim

# Inherit global arguments
ARG HOME
ARG OUTPUT_DIR
ARG WORK_DIR

ENV FEAPPVHOME5_1=${OUTPUT_DIR} \
  SEHLL=bash \
  # --For WSLg(Windows Subsytem for Linux GUI) settings
  PULSE_SERVER=/mnt/wslg/PulseServer \
  WAYLAND_DISPLAY=wayland-0 \
  XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir

# get remote repository
ADD --chown=true https://github.com/sanjayg0/feappv.git ${OUTPUT_DIR}

WORKDIR ${OUTPUT_DIR}
RUN cp ./makefile.in_gfortran ./makefile.in && \
  make install; \
  "alias feappv=${OUTPUT_DIR}/main/feappv" > ${HOME}/.bashrc

WORKDIR ${WORK_DIR}
