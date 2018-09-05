FROM openjdk:8-jre-alpine

ENV TRACCAR_VERSION 3.9
ENV TRACCAR_WEB_VERSION 0.12.3

WORKDIR /opt/traccar

RUN set -ex && \
    apk add --no-cache wget && \
    \
    wget -qO /tmp/traccar.zip https://github.com/tananaev/traccar/releases/download/v$TRACCAR_VERSION/traccar-other-$TRACCAR_VERSION.zip && \
    unzip -qo /tmp/traccar.zip -d /opt/traccar && \
    wget -qO /opt/traccar/traccar-web.war https://github.com/vitalidze/traccar-web/releases/download/$TRACCAR_WEB_VERSION/traccar-web.war && \
    rm /tmp/traccar.zip && \
    \
    apk del wget

COPY schema.sql schema.sql
COPY traccar.xml conf/traccar.xml
COPY default.xml conf/default.xml
COPY start.sh start.sh

VOLUME ["/opt/traccar/data","/opt/traccar/logs"]

EXPOSE 8082
EXPOSE 5000-5150/tcp
EXPOSE 5000-5150/udp

ENTRYPOINT ["/bin/sh"]

CMD ["start.sh"]
