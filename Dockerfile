FROM ubuntu

RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    gfortran \
    unzip \
    wget \
    xserver-xorg-dev \
 && rm -rf /var/lib/apt/lists/*

ENV FEAPPVHOME3_1 /feappv/ver31
WORKDIR /feappv
ADD http://www.ce.berkeley.edu/projects/feap/feappv/feappv31.zip .
COPY makefile.in .

RUN unzip feappv31.zip \
 && mkdir -p decks \
 && cp makefile.in ver31/ \
 && cd ver31 \
 && make install

WORKDIR /feappv/decks
CMD /feappv/ver31/main/feappv