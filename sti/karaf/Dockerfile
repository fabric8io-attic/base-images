FROM jboss/base-jdk:8

MAINTAINER Dhiraj Bokde <dhirajsb@gmail.com>

ENV MAVEN_VERSION=3.3.3
ENV JOLOKIA_VERSION=1.3.1

# Expose jolokia port
EXPOSE 8778

LABEL io.fabric8.s2i.version.maven=3.3.3 \
      io.fabric8.s2i.version.jolokia=1.3.1 \
      io.k8s.description="Platform for building and running Apache Karaf OSGi applications" \
      io.k8s.display-name="Apache Karaf" \
      io.openshift.expose-services="8778:jolokia" \
      io.openshift.s2i.scripts-url="image:///usr/local/s2i" \
      io.openshift.tags="builder,karaf"

# Copy the S2I scripts to /usr/local/s2i and add to PATH
COPY ./.s2i/bin/ /usr/local/s2i
ENV PATH /usr/local/s2i:$PATH

# Temporary switch to root
USER root

# Install maven
RUN curl http://www.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | \
    tar -xzf - -C /opt \
 && ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven \
 && ln -s /opt/maven/bin/mvn /usr/bin/mvn

# download jolokia in the sti builder
RUN mkdir /opt/jolokia \
 && curl -L http://central.maven.org/maven2/org/jolokia/jolokia-jvm/${JOLOKIA_VERSION}/jolokia-jvm-${JOLOKIA_VERSION}-agent.jar \
         > /opt/jolokia/jolokia.jar

# Jolokia config
COPY ./jolokia.properties /opt/jolokia/jolokia.properties

# Copy deploy-and-run.sh for standalone images
COPY ./deploy-and-run.sh /opt/karaf/bin/
RUN chmod a+x /opt/karaf/bin/deploy-and-run.sh

# allow jboss user access to /opt/jboss and /opt/karaf
RUN chown -R 1000 /opt/jboss \
    && chown -R 1000 /opt/karaf

# STI requires a numeric, non-0 UID
USER 1000

CMD ["usage"]
