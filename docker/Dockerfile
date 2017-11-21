FROM        debian:jessie
MAINTAINER  Ju <julien@nitronet.org>

ARG DOCKER_TIMEZONE=Europe/Paris

# Configure timezone
# -----------------------------------------------------------------------------
RUN echo $DOCKER_TIMEZONE > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata

RUN apt-get -qq update && apt-get install -qq -y curl \
    bash \
    sudo \
    nano \
    gcc \
    flex \
    make \
    bison \
    wget \
    unzip \
    python \
    libpcre3 \
    libpcre3-dev \
    sqlite

RUN useradd -c 'IRC user' -m -d /home/ircnet -s /bin/bash ircnet

# install IRC things
USER ircnet

RUN cd /home/ircnet && \
    wget https://github.com/quakenet/snircd/archive/master.zip && \
    unzip master.zip && \
    cd snircd-master && \
    ./configure --prefix=/home/ircnet/ircd --with-maxcon=100000 && \
    make && make install && \
    cd .. && rm master.zip

RUN cd /home/ircnet && \
    wget https://github.com/quakenet/newserv/archive/master.zip && \
    unzip master.zip && \
    cd newserv-master && \
    ./configure && \
    make && make install && \
    cd .. && rm master.zip

USER root

COPY bootstrap.sh /root/bootstrap.sh
RUN chmod 755 /root/bootstrap.sh

EXPOSE 6667
EXPOSE 4400

ENTRYPOINT /root/bootstrap.sh
