FROM phusion/baseimage

RUN apt-get update && \
 DEBIAN_FRONTEND="noninteractive" apt-get install -y git vim curl wget python-software-properties \
    multitail build-essential libtool automake autoconf checkinstall cmake g++

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y imagemagick libpng-dev libjpeg-dev libtiff-dev libopencv-dev


RUN mkdir ~/temp \
  && cd ~/temp/ \
  && wget http://www.leptonica.org/source/leptonica-1.72.tar.gz \
  && tar -zxvf leptonica-1.72.tar.gz \
  && cd leptonica-1.72 \
  && ./configure \
  && make \
  && checkinstall \
  && ldconfig

RUN cd ~/temp/ \
  && git clone https://github.com/tesseract-ocr/tesseract.git \
  && cd tesseract \
  && ./autogen.sh \
  && ./configure \
  && make \
  && make install \
  && ldconfig \
  && cd ~/temp/ \
  && wget https://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.eng.tar.gz \
  && tar xvf tesseract-ocr-3.02.eng.tar.gz \
  && cp -rf tesseract-ocr/tessdata/* /usr/local/share/tessdata/

ENV TESSDATA_PREFIX /usr/local/share/tessdata/

WORKDIR /root
