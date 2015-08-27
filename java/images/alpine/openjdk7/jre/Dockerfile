FROM alpine:3.2
RUN apk add --update \
    curl \
    openjdk7-jre-base \
 && rm /var/cache/apk/*

# Agent bond
ADD agent-bond-opts /bin/
RUN mkdir -p /opt/agent-bond \
 && curl http://central.maven.org/maven2/io/fabric8/agent-bond-agent/0.1.0/agent-bond-agent-0.1.0.jar \
          -o /opt/agent-bond/agent-bond.jar \
 && chmod 444 /opt/agent-bond/agent-bond.jar \
 && chmod 755 /bin/agent-bond-opts
ADD jmx_exporter_config.json /opt/agent-bond/
EXPOSE 8778 9779
# Add run script to /
COPY run-java.sh /


RUN mkdir /app \
 && chmod 755 /run-java.sh

CMD [ "/run-java.sh" ]
