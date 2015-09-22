FROM jboss/base-jdk:8

MAINTAINER Dhiraj Bokde <dhirajsb@gmail.com>

ENV JOLOKIA_VERSION=1.3.1

# Expose jolokia port
EXPOSE 8778

LABEL io.k8s.description="Platform for building and running Apache Karaf OSGi applications" \
            io.k8s.display-name="Apache Karaf" \
            io.openshift.expose-services="8778/tcp:jolokia" \
            io.openshift.s2i.scripts-url="image://usr/local/s2i" \
            io.openshift.tags="builder,karaf"

# Copy the S2I scripts to /usr/local/s2i
COPY ./.s2i/bin/ /usr/local/s2i

# Temporary switch to root
USER root

# download jolokia in the sti builder
RUN mkdir /opt/jolokia \
 && curl -L http://central.maven.org/maven2/org/jolokia/jolokia-jvm/${JOLOKIA_VERSION}/jolokia-jvm-${JOLOKIA_VERSION}-agent.jar \
         > /opt/jolokia/jolokia.jar

# Jolokia config
COPY ./jolokia.properties /opt/jolokia/jolokia.properties

# Copy deploy-and-run.sh for standalone images
COPY ./deploy-and-run.sh /opt/karaf/bin/
RUN chmod a+x /opt/karaf/bin/deploy-and-run.sh

# allow jboss user access to /opt/jboss
RUN chown -R jboss:jboss /opt/jboss

# STI requires a numeric, non-0 UID
USER jboss

CMD ["/usr/local/s2i/usage"]
