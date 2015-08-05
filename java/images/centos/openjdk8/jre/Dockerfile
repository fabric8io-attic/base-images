FROM centos
RUN yum install -y \
       java-1.8.0-openjdk 

# Agent bond
ADD agent-bond-opts /bin/
RUN chmod 755 /bin/agent-bond-opts \
 && mkdir -p /opt/agent-bond \
 && curl http://central.maven.org/maven2/io/fabric8/agent-bond-agent/0.1.0/agent-bond-agent-0.1.0.jar \
          -o /opt/agent-bond/agent-bond.jar \
 && chmod 444 /opt/agent-bond/agent-bond.jar
ADD jmx_exporter_config.json /opt/agent-bond/
EXPOSE 8778 9779

ADD run-java.sh /
RUN mkdir /app \
 && chmod 755 /run-java.sh

CMD [ "/run-java.sh" ]
