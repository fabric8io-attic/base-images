FROM openshift/base-centos7

# Directory which will hold the source provided by STI
LABEL io.openshift.s2i.destination /tmp

# Some version information
LABEL io.fabric8.s2i.version.maven=3.3.3 \
      io.fabric8.s2i.version.agent-bond=undefined \
      io.k8s.description="Platform for building and running plain Java applications (flat classpath or fat jars)" \
      io.k8s.display-name="Java Applications" \
      io.openshift.tags="builder,java" \
      io.openshift.s2i.scripts-url=image:///usr/local/sti

USER root


# Standard Java 8 from the repo
ENV JAVA_HOME /etc/alternatives/java_sdk
RUN yum install -y \
    java-1.8.0-openjdk-headless \
    java-1.8.0-openjdk-devel.x86_64 \
 && yum clean all -y \
 && curl http://www.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz | \
    tar -xzf - -C /opt \
 && ln -s /opt/apache-maven-3.3.3 /opt/maven \
 && ln -s /opt/maven/bin/mvn /usr/bin/mvn


# Agent bond including Jolokia and jmx_exporter
ADD agent-bond-opts /usr/bin/run-java-options
RUN mkdir -p /opt/agent-bond \
 && curl http://central.maven.org/maven2/io/fabric8/agent-bond-agent/0.1.0/agent-bond-agent-0.1.0.jar \
          -o /opt/agent-bond/agent-bond.jar \
 && chmod 444 /opt/agent-bond/agent-bond.jar \
 && chmod 755 /usr/bin/run-java-options
ADD jmx_exporter_config.json /opt/agent-bond/
EXPOSE 8778 9779
LABEL io.openshift.expose-services 8778/tcp:jolokia,9779/tcp:jmx_exporter


# /usr/local/sti is set as script directory in base image
COPY sti /usr/local/sti

# Copy run script and enable an empty configuration config file with
# the proper configuration
# Add run script as /usr/local/sti/run
COPY run-java.sh /usr/local/sti/run

RUN chmod a+x /usr/local/sti/* \
 && touch /usr/local/sti/run-env.sh \
 && chown 1000 /usr/local/sti/run-env.sh \
 && chmod 666 /usr/local/sti/run-env.sh

ADD README.md /usr/local/sti/usage.txt

# STI requires a numeric, non-0 UID
USER 1000
