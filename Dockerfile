FROM ubuntu

RUN apt update && apt install -y \
 build-essential \
 gcc \
 gfortran \
 unzip \
 wget \
 xserver-xorg-dev \
 && rm -rf /var/lib/apt/lists/*

ENV FEAPPVHOME5_1 /feappv/feappv-5.1.1c
ENV feap=/feappv/feappv-5.1.1c/main/feappv
WORKDIR /feappv
ADD https://github.com/sanjayg0/feappv/archive/v5.1.1c.zip .
COPY makefile.in .

RUN unzip v5.1.1c.zip \
 && mkdir -p decks \
 && cp makefile.in feappv-5.1.1c/ \
 && cd feappv-5.1.1c \
 && make install

#Error
# RUN echo "alias feap='/feappv/feappv-5.1.1c/main/feappv'" >> /root/home/.bashrc

WORKDIR /feappv/decks
CMD /feappv/feappv-5.1.1c/main/feappv
