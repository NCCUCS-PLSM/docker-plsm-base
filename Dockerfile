FROM atkinschang/docker-baseimage:latest-jdk8

MAINTAINER Atkins Chang "atkinschang@icloud.com"

ENV HOME /root
RUN mkdir /tmp/build
COPY . /tmp/build

RUN /tmp/build/install.sh

CMD ["/sbin/my_init","--","bash","-l"]