FROM {{= it.param.base }}

# Directory which will hold the source provided by STI
LABEL

ADD agent-bond-opts /bin/

# Standard Java 8 from the repo
RUN yum install -y java-1.8.0-openjdk-headless \
 && yum clean all -y \
 && curl http://www.apache.org/dist/maven/maven-{{= it.version.mavenMajor}}/{{= it.version.maven }}/binaries/apache-maven-{{= it.version.maven }}-bin.tar.gz | \
    tar -xzf - -C /opt \
 && ln -s /opt/apache-maven-{{= it.version.maven }} /opt/maven \
 && ln -s /opt/maven/bin/mvn /usr/bin/mvn \
 && chmod 755 /bin/agent-bond-opts \
 && mkdir -p /opt/agent-bond \
 && curl http://central.maven.org/maven2/io/fabric8/agent-bond-agent/{{= it.version.agentBond }}/agent-bond-agent-{{= it.version.agentBond }}.jar \
          -o /opt/agent-bond/agent-bond.jar \
 && chmod 444 /opt/agent-bond/agent-bond.jar

ADD jmx_exporter_config.json /opt/agent-bond/

EXPOSE 8778 9779

# /usr/local/sti is set as script directory in base image
COPY sti /usr/local/

RUN chmod a+x /usr/local/sti/*

