FROM {{= fp.config.base.from }}

# Directory which will hold the source provided by STI
LABEL io.openshift.s2i.destination /tmp

# Some version information
LABEL io.fabric8.s2i.version.maven {{= fp.version.maven }}
LABEL io.fabric8.s2i.version.agentbond  {{= fp.version.agentBond }}

ADD README.md /tmp/README.md

# Standard Java 8 from the repo
RUN yum install -y \
    java-1.8.0-openjdk-headless \
    java-1.8.0-openjdk-devel.x86_64 \
    pandoc \
 && yum clean all -y \
 && curl http://www.apache.org/dist/maven/maven-{{= fp.version.mavenMajor}}/{{= fp.version.maven }}/binaries/apache-maven-{{= fp.version.maven }}-bin.tar.gz | \
    tar -xzf - -C /opt \
 && ln -s /opt/apache-maven-{{= fp.version.maven }} /opt/maven \
 && ln -s /opt/maven/bin/mvn /usr/bin/mvn \
 && pandoc -s -f markdown -t man /tmp/README.md | nroff -man > /usr/local/sti/usage.txt \
 && yum -y remove pandoc \
 && yum -y autoremove \
 && rm /tmp/README.md

ENV JAVA_HOME /etc/alternatives/java_sdk

# agent-bond with Jolokia and jmx_exporter
{{= fp.block('agent-bond','install',{ dest: "/usr/bin/run-java-options", openshift: true }) }}

# /usr/local/sti is set as script directory in base image
COPY sti /usr/local/sti

# Copy run script and enable an empty configuration config file with
# the proper configuration
{{= fp.block('run-java-sh','copy',{ dest: "/usr/local/sti/run" }) }}
RUN chmod a+x /usr/local/sti/* \
 && touch /usr/local/sti/run-env.sh \
 && chown 1611 /usr/local/sti/run-env.sh

# STI requires a numeric, non-0 UID
USER 1611

