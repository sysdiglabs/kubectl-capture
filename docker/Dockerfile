FROM sysdig/sysdig:latest

MAINTAINER Néstor Salceda <nestor.salceda@sysdig.com>

ENV CAPTURE_DURATION 120

COPY ./docker-entrypoint.sh /

RUN mkdir -p /captures

ENTRYPOINT ["/docker-entrypoint.sh"]
