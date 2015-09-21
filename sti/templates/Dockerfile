FROM {{= fp.config.base.from }}

# Directory which will hold the source provided by STI
LABEL io.openshift.s2i.destination /tmp

# Some version information
LABEL io.fabric8.s2i.version.maven {{= fp.version.maven }} \
      io.fabric8.s2i.version.{{= fp.config.base.agent }} {{= fp.version[fp.config.base.agent] }} \
      io.k8s.description="Platform for building and running plain Java applications (flat classpath or fat jars)" \
      io.k8s.display-name="Java Applications" \
      io.openshift.s2i.scripts-url="image://usr/local/s2i" \
      io.openshift.tags="builder,java"

USER root

{{? fp.config.base.installJava }}
# Standard Java 8 from the repo
ENV JAVA_HOME /etc/alternatives/java_sdk
RUN yum install -y \
    java-1.8.0-openjdk-headless \
    java-1.8.0-openjdk-devel.x86_64 \
 && yum clean all -y \
 && {{??}}RUN {{?}}curl http://www.apache.org/dist/maven/maven-{{= fp.version.mavenMajor}}/{{= fp.version.maven }}/binaries/apache-maven-{{= fp.version.maven }}-bin.tar.gz | \
    tar -xzf - -C /opt \
 && ln -s /opt/apache-maven-{{= fp.version.maven }} /opt/maven \
 && ln -s /opt/maven/bin/mvn /usr/bin/mvn

{{? fp.config.base.agent }}
{{= fp.block(fp.config.base.agent,'install',{ dest: "/usr/bin/run-java-options", openshift: true }) }}
{{?}}

# /usr/local/sti is set as script directory in base image
COPY sti /usr/local/sti

# Copy run script and enable an empty configuration config file with
# the proper configuration
{{= fp.block('run-java-sh','copy',{ dest: "/usr/local/sti/run" }) }}
RUN chmod a+x /usr/local/sti/* \
 && touch /usr/local/sti/run-env.sh \
 && chown 1611 /usr/local/sti/run-env.sh

ADD README.md /usr/local/sti/usage.txt

# STI requires a numeric, non-0 UID
USER 1611

