FROM jboss/base-jdk:8

# Some version information
LABEL io.fabric8.s2i.version.maven=3.3.3 \
      io.fabric8.s2i.version.jolokia=1.3.1 \
      io.k8s.description="Platform for building and running plain Java applications (flat classpath or fat jars)" \
      io.k8s.display-name="Java Applications" \
      io.openshift.tags="builder,java" \
      io.openshift.s2i.scripts-url=image:///usr/local/sti \
      io.openshift.s2i.destination=/tmp

USER root

RUN curl http://www.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz | \
    tar -xzf - -C /opt \
 && ln -s /opt/apache-maven-3.3.3 /opt/maven \
 && ln -s /opt/maven/bin/mvn /usr/bin/mvn


# Jolokia agent
ADD jolokia-opts /usr/bin/run-java-options
RUN mkdir -p /opt/jolokia \
 && curl http://central.maven.org/maven2/org/jolokia/jolokia-jvm/1.3.1/jolokia-jvm-1.3.1-agent.jar \
         -o /opt/jolokia/jolokia.jar \
 && chmod 444 /opt/jolokia/jolokia.jar \
 && chmod 755 /usr/bin/run-java-options
EXPOSE 8778
LABEL io.openshift.expose-services 8778/tcp:jolokia


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

ENV PATH=$PATH:/usr/local/sti
