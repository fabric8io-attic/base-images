FROM openshift/base-rhel7

# Directory which will hold the source provided by STI
LABEL io.openshift.s2i.destination /tmp

# Some version information
LABEL io.fabric8.s2i.version.maven 3.3.3
LABEL io.fabric8.s2i.version.agentbond  0.1.0

ADD README.md /tmp/README.md

# Standard Java 8 from the repo
RUN yum install -y \
    java-1.8.0-openjdk-headless \
    java-1.8.0-openjdk-devel.x86_64 \
    pandoc \
 && yum clean all -y \
 && curl http://www.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz | \
    tar -xzf - -C /opt \
 && ln -s /opt/apache-maven-3.3.3 /opt/maven \
 && ln -s /opt/maven/bin/mvn /usr/bin/mvn \
 && pandoc -s -f markdown -t man /tmp/README.md | nroff -man > /usr/local/sti/usage.txt \
 && yum -y remove pandoc \
 && yum -y autoremove \
 && rm /tmp/README.md

ENV JAVA_HOME /etc/alternatives/java_sdk

# agent-bond with Jolokia and jmx_exporter
undefined

# /usr/local/sti is set as script directory in base image
COPY sti /usr/local/sti

# Add run script to /usr/local/sti/run
COPY run-java.sh /usr/local/sti/run

RUN chmod a+x /usr/local/sti/*
