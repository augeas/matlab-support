# augeas/matlab-support
# 
# Create an image with enough dependencies to support a mounted-in matlab.
#
# Gratefully stolen from Benjamin Heasly: https://github.com/benjamin-heasly/matlab-support/

FROM ubuntu:16.04

MAINTAINER Giles Greenway <augeas@gmail.com>

RUN  echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" \
    | debconf-set-selections && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > \
    /etc/apt/sources.list.d/webupd8team-java-trusty.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
    apt-get update && \
    apt-get install -y --no-install-recommends oracle-java8-installer \
    oracle-java8-set-default 

# Matlab dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libpng12-dev \
    libfreetype6-dev \
    libblas-dev \
    liblapack-dev \
    gfortran \
    build-essential \
    libgl1-mesa-glx \
    xorg

ENV MATLAB_JAVA=/usr/lib/jvm/java-8-oracle/jre/

ENV PATH="/usr/local/MATLAB/from-host/bin:${PATH}"

# default to matlab with no desktop:
CMD ["matlab","-nodesktop"]

