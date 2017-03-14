FROM centos:7.2.1511

MAINTAINER Roman Mohr <rmohr@redhat.com>

EXPOSE 3128

RUN yum install -y squid && yum clean all

RUN sed -i -e "s/http_access deny CONNECT !SSL_ports/http_access deny CONNECT !Safe_ports/" /etc/squid/squid.conf

CMD squid -NCd1
