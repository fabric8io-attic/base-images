FROM jboss/base-jdk:7

USER root

RUN mkdir /app
ENV JAVA_APP_DIR /app


# Jolokia agent
ADD jolokia-opts /opt/run-java-options
RUN mkdir -p /opt/jolokia \
 && curl http://central.maven.org/maven2/org/jolokia/jolokia-jvm/1.3.1/jolokia-jvm-1.3.1-agent.jar \
         -o /opt/jolokia/jolokia.jar \
 && chmod 444 /opt/jolokia/jolokia.jar \
 && chmod 755 /opt/run-java-options
EXPOSE 8778

# Add run script as /app/run-java.sh and make it executable
COPY run-java.sh /app/run-java.sh
RUN chmod 755 /app/run-java.sh


# Run under user "jboss"
RUN chown -R jboss /app
USER jboss


CMD [ "/app/run-java.sh" ]
