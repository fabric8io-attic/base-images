FROM alpine:3.2
# Experimental setup for JDK8 on Alpine Linux which requires glibc, too.
# Maybe the cleanup could be even more aggressive
RUN apk add --update curl tar xz ca-certificates \
 && cd /tmp \
 && curl "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk" -O \
 && curl "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-bin-2.21-r2.apk" -O \
 && apk add --allow-untrusted glibc-2.21-r2.apk glibc-bin-2.21-r2.apk \
 && /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib \
 && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
 && curl -L http://www.java.net/download/jdk8u60/archive/b18/binaries/jre-8u60-ea-bin-b18-linux-x64-02_jun_2015.tar.gz -o /tmp/jdk.tgz \
 && mkdir /opt \
 && cd /opt \
 && tar xf /tmp/jdk.tgz \
 && cd /tmp \
 && ln -s /opt/*1.8* /opt/jdk \
 && ln -s /opt/jdk/bin/java /usr/bin/java \
 && apk del ca-certificates tar xz \
 && rm /tmp/* /var/cache/apk/* \
 && rm -rf /opt/jdk/demo /opt/jdk/sample /opt/jdk/man /opt/jdk/src.zip

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


RUN mkdir /app \
 && chmod 755 /run-java.sh

CMD [ "/run-java.sh" ]
