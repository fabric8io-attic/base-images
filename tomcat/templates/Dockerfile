{{
  var cfg = fp.config.version;
  var base = "apache-tomcat";
  var majorVersion = cfg.version.replace(/^([^.]+).*$/,"$1");
  var url = cfg.url ||
           "http://archive.apache.org/dist/tomcat/tomcat-" + majorVersion +
           "/v${TOMCAT_VERSION}/bin/" + base + "-${TOMCAT_VERSION}.tar.gz";
  var toRemove = cfg.toRemove;
  var roleFile = cfg.roleFile;
  var jolokiaVersion = cfg.jolokiaVersion;
}}
FROM {{= fp.config.version.from }}

MAINTAINER {{= fp.maintainer }}

EXPOSE 8080

ENV TOMCAT_VERSION {{= fp.config.version.version }}
ENV DEPLOY_DIR /maven

# Get and Unpack Tomcat
RUN curl {{= url }} -o /tmp/catalina.tar.gz \
 && tar xzf /tmp/catalina.tar.gz -C /opt \
 && ln -s /opt/{{= base }}-${TOMCAT_VERSION} /opt/tomcat \
 && rm /tmp/catalina.tar.gz

# Add roles
ADD tomcat-users.xml /opt/{{= base}}-${TOMCAT_VERSION}/conf/

# Startup script
ADD deploy-and-run.sh /opt/{{= base}}-${TOMCAT_VERSION}/bin/

RUN chmod 755 /opt/{{= base}}-${TOMCAT_VERSION}/bin/deploy-and-run.sh \
 && rm -rf {{~toRemove :value:index}}/opt/tomcat/webapps/{{=value}} {{~}}

VOLUME ["/opt/tomcat/logs", "/opt/tomcat/work", "/opt/tomcat/temp", "/tmp/hsperfdata_root" ]

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

CMD /opt/tomcat/bin/deploy-and-run.sh

