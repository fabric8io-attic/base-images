FROM centos:7
RUN yum install -y \
       java-1.7.0-openjdk \
       java-1.7.0-openjdk-devel

ENV JAVA_HOME /etc/alternatives/jre

# Agent bond including Jolokia and jmx_exporter
ADD agent-bond-opts /bin/agent-bond-options
RUN mkdir -p /opt/agent-bond \
 && curl http://central.maven.org/maven2/io/fabric8/agent-bond-agent/0.1.0/agent-bond-agent-0.1.0.jar \
          -o /opt/agent-bond/agent-bond.jar \
 && chmod 444 /opt/agent-bond/agent-bond.jar \
 && chmod 755 /bin/agent-bond-options
ADD jmx_exporter_config.json /opt/agent-bond/
EXPOSE 8778 9779

# Add run script as /
COPY run-java.sh /


USER root

RUN mkdir /app \
 && chmod 755 /run-java.sh

CMD [ "/run-java.sh" ]
