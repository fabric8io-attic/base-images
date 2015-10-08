FROM jboss/base-jdk:8

ENV MAVEN_VERSION=3.3.3
ENV JOLOKIA_VERSION=1.3.1

# Some version information
LABEL io.fabric8.s2i.version.maven=3.3.3 \
      io.fabric8.s2i.version.jolokia=1.3.1 \
      io.k8s.description="Platform for building and running plain Java applications (flat classpath or fat jars)" \
      io.k8s.display-name="Java Applications" \
      io.openshift.tags="builder,java" \
      io.openshift.s2i.scripts-url=image:///usr/local/s2i \
      io.openshift.s2i.destination=/tmp

# Temporary switch to root
USER root

# Install maven
RUN curl http://www.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | \
    tar -xzf - -C /opt \
 && ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven \
 && ln -s /opt/maven/bin/mvn /usr/bin/mvn

# Jolokia agent
ADD jolokia-opts /opt/jolokia/
RUN mkdir -p /opt/jolokia \
 && curl http://central.maven.org/maven2/org/jolokia/jolokia-jvm/${JOLOKIA_VERSION}/jolokia-jvm-${JOLOKIA_VERSION}-agent.jar \
         -o /opt/jolokia/jolokia.jar \
 && chmod 444 /opt/jolokia/jolokia.jar \
 && chmod 755 /opt/jolokia/jolokia-opts
EXPOSE 8778

# /usr/local/sti is set as script directory in base image
COPY s2i /usr/local/s2i

ADD README.md /usr/local/sti/usage.txt

# Necessary to permit running with a randomised UID
RUN chmod -R a+rwX /opt/jboss \
 && mkdir /opt/src \
 && chmod -R a+rwX /opt/src

# STI requires a numeric, non-0 UID
USER 1000

ENV PATH=$PATH:/usr/local/s2i
