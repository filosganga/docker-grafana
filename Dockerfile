# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:latest
MAINTAINER Filippo De Luca <me@filippodeluca.com>

# Set correct environment variables.
ENV HOME /root
ENV GRAFANA_VERSION 1.8.1


# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN apt-get -y update\
 && apt-get -y upgrade

RUN apt-get -y --force-yes install wget\
	nginx

WORKDIR /srv

# config grafana
RUN wget http://grafanarel.s3.amazonaws.com/grafana-${GRAFANA_VERSION}.tar.gz -O /srv/grafana-${GRAFANA_VERSION}.tar.gz
RUN tar -xzvf grafana-${GRAFANA_VERSION}.tar.gz && rm grafana-${GRAFANA_VERSION}.tar.gz && ln -s grafana-${GRAFANA_VERSION} grafana
ADD conf/grafana/config.js /srv/grafana/config.js
ADD conf/grafana/logrotate /etc/logrotate.d/grafana

# config nginx
RUN rm /etc/nginx/sites-enabled/default
ADD conf/nginx/nginx.conf /etc/nginx/nginx.conf
ADD conf/nginx/grafana.conf /etc/nginx/sites-available/grafana.conf
RUN ln -s /etc/nginx/sites-available/grafana.conf /etc/nginx/sites-enabled/grafana.conf
RUN mkdir -p /var/log/nginx
ADD conf/nginx/logrotate /etc/logrotate.d/nginx

# Daemons
ADD daemons/nginx.sh /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
VOLUME ["/srv/grafana", "/etc/nginx", "/etc/logrotate.d", "/var/log"]

ENV HOME /root
# Use baseimage-docker's init system.
ENTRYPOINT ["/sbin/my_init"]