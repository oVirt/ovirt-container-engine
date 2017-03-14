FROM alpine:3.5
MAINTAINER "Yaniv Bronhaim" <ybronhei@redhat.com>
RUN apk update && apk add rsyslog && rm -rf /var/cache/apk/*

EXPOSE 514 514/tcp
COPY rsyslog.conf /etc/rsyslog.conf
ENTRYPOINT [ "rsyslogd", "-n", "-f", "/etc/rsyslog.conf" ]
