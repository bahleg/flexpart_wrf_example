FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive

# FLEXPART INSTALLATION
RUN apt-get update && apt-get update && apt-get install -y \
  language-pack-en openssh-server vim software-properties-common \
  build-essential make gcc g++ zlib1g-dev git python3 python3-dev python3-pip \
  pandoc python3-setuptools imagemagick\
  gfortran autoconf libtool automake flex bison cmake git-core \
  libjpeg8-dev libfreetype6-dev libhdf5-serial-dev \
  libeccodes0 libeccodes-data libeccodes-dev \
  libnetcdf-c++4 libnetcdf-c++4-dev libnetcdff-dev \
  binutils  python3-numpy python3-mysqldb \
  python3-scipy python3-sphinx libedit-dev unzip curl wget
  
  
# replaced 'libpng12-dev' by libpng-dev
RUN add-apt-repository ppa:ubuntugis/ppa \
  && apt-get update \
  && apt-get install -y libatlas-base-dev libpng-dev \
     libproj-dev libgdal-dev gdal-bin  
RUN add-apt-repository 'deb http://security.ubuntu.com/ubuntu xenial-security main' \
  && apt-get update \
  && apt-get install -y libjasper1 libjasper-dev libeccodes-tools libeccodes-dev
#ENV HTTP https://confluence.ecmwf.int/download/attachments/45757960
#ENV ECCODES eccodes-2.9.2-Source
#
# Download, modify and compile flexpart 10
#


RUN mkdir flex_src && cd flex_src \
  && wget https://www.flexpart.eu/downloads/58 \
  && tar -xvf 58 \
  && rm 58 
  
COPY makefile.mom  flex_src/Src_flexwrf_v3.3.2/makefile.mom
RUN cd /flex_src/Src_flexwrf_v3.3.2 && make -f makefile.mom serial
WORKDIR flex_src/Src_flexwrf_v3.3.2

ENTRYPOINT tail -f /dev/null
