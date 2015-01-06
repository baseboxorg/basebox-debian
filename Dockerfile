FROM debian:latest

MAINTAINER BaseBoxOrg <open@basebox.org>

ENV DEBIAN_FRONTEND noninteractive

# Install packages
RUN apt-get update && apt-get -y install git openssh-server pwgen locales

RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config

ADD set_root_pw.sh /set_root_pw.sh

ADD run.sh /run.sh

RUN chmod +x /*.sh

RUN dpkg-reconfigure locales && \
  locale-gen C.UTF-8 && \
  /usr/sbin/update-locale LANG=C.UTF-8

RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
  locale-gen

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8


EXPOSE 22

CMD ["/run.sh"]
