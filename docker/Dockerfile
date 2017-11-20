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
    bison

RUN useradd -c 'IRC user' -m -d /home/ircnet -s /bin/bash ircnet

ADD ./sources /home/ircnet/sources

WORKDIR /home/ircnet

# install IRC things
USER ircnet

RUN tar xzf ircu2.10.12.18.tar.gz && \
    mv ircu2.10.12.18 /home/ircnet/ircu2.10.12.18 && \
    cd /home/ircnet/ircu2.10.12.18 && \
    ./configure --prefix=/home/ircnet/ircd && \
    make && make install

COPY bootstrap.sh /root/bootstrap.sh
RUN chmod 755 /root/bootstrap.sh

EXPOSE 6667

WORKDIR /home/ircnet

CMD ["/root/bootstrap.sh"]
