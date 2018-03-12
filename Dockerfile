# ninjaben/matlab-support
# 
# Create an image with enough dependencies to support a mounted-in matlab.
#
# These expect you to define some local information:
# - `MATLAB_ROOT` is your matlab installation on the Docker host, perhaps `/usr/local/MATLAB/R2016a`.
# - `MATLAB_LOGS` is optional path on the Docker host to receive Matlab logs, perhaps `~/matlab-logs`.
# - `MATLAB_MAC_ADDRESS` is the MAC address associated with your own Matlab License, of the form `00:00:00:00:00:00`.
#
# Print Matlab command help:
# docker run --rm -v "$MATLAB_ROOT":/usr/local/MATLAB/from-host -v "$MATLAB_LOGS":/var/log/matlab --mac-address="$MATLAB_MAC_ADDRESS" ninjaben/matlab-support
#
# Launch Matlab and print version info:

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

# run the container like a matlab executable 
ENV PATH="/usr/local/MATLAB/from-host/bin:${PATH}"
#ENTRYPOINT ["matlab", "-logfile /var/log/matlab/matlab.log"]

# default to matlab help
CMD ["matlab","-nodesktop"]

