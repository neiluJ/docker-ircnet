FROM        debian:jessie
MAINTAINER  Ju <julien@nitronet.org>

ARG DOCKER_TIMEZONE=Europe/Paris

ENV IRCU_SOURCES ircu2.10.12.18.tar.gz
ENV IRCU_VERSION 2.10.12.18

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

COPY sources/$IRCU_SOURCES /home/ircnet/$IRCU_SOURCES

# install IRC things
USER ircnet

RUN cd /home/ircnet && tar xzf $IRCU_SOURCES && \
    cd ircu$IRCU_VERSION && \
    ./configure --prefix=/home/ircnet/ircd --with-maxcon=100000 && \
    make && make install

RUN cd /home/ircnet && \
    wget https://github.com/quakenet/newserv/archive/master.zip && \
    unzip master.zip && \
    cd newserv-master && \
    ./configure && \
    make && make install

USER root

COPY bootstrap.sh /root/bootstrap.sh
RUN chmod 755 /root/bootstrap.sh

EXPOSE 6667
EXPOSE 4400

ENTRYPOINT /root/bootstrap.sh
