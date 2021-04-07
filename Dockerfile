FROM golang:1.15.11-buster

RUN apt update && apt-get install -y neovim openssh-server docker docker-compose sudo zsh locales

# locale settings so pretty fonts/zsh themes work
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
  locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN systemctl enable ssh docker

# remove ssh keys
RUN rm -vrf /etc/ssh/ssh_host*

# provide a fake modprobe
RUN ln -s true /bin/modprobe

# switch to compat iptables (otherwise docker fails)
RUN \
  update-alternatives --set iptables /usr/sbin/iptables-legacy && \
  update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

RUN groupadd -g 1000 pair
RUN useradd -u 1000 -g 1000 --groups docker,sudo,users -ms /bin/zsh pair && \
  chown -R root:users /usr/local && \
  chmod -R 775 /usr/local

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

VOLUME [ "/sys/fs/cgroup" ]

COPY run.sh /run.sh
CMD ["/run.sh"]
