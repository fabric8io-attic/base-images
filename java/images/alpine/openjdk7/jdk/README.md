## Fabric8 Java Base Image

This image is based on Alpine and provides
OpenJDK 7, jdk

It includes:

* An [Agent Bond](https://github.com/fabric8io/agent-bond) agent with [Jolokia](http://www.jolokia.org) 
  and Prometheus' [jmx_exporter](https://github.com/prometheus/jmx_exporter). 
  The agent is installed as `/opt/agent-bond/agent-bond.jar`. 

* A startup script [`/run-java.sh`](#startup-script-run-java.sh) for starting up Java applications.

### Agent Bond

In order to enable Jolokia for your application you should use this 
image as a base image (via `FROM`) and use the output of `agent-bond-opts` in 
your startup scripts to include it in for the Java startup options. 

For example, the following snippet can be added to a script starting up your 
Java application

    # ...
    export JAVA_OPTIONS="$JAVA_OPTIONS $(agent-bond-opts)"
    # .... us JAVA_OPTIONS when starting your app, e.g. as Tomcat does

You can influence the behaviour of `agent-bond-opts` by setting various environment 
variables:

* **AB_OFF** : If set disables activation of agent-bond (i.e. echos an empty value). By default, agent-bond is enabled.
* **AB_ENABLED** : Comma separated list of sub-agents enabled. Currently allowed values are `jolokia` and `jmx_exporter`. 
  By default both are enabled.

So, if you start the container with `docker run -e AB_OFF ...` no agent will be launched.

The following versions and defaults are used:

* [Jolokia](http://www.jolokia.org) : version **1.3.1** and port **8778**
* [jmx_exporter](https://github.com/prometheus/jmx_exporter): version **undefined** and port **9779**  

#### Jolokia configuration

* **AB_JOLOKIA_CONFIG** : If set uses this file (including path) as Jolokia JVM agent properties (as described 
  in Jolokia's [reference manual](http://www.jolokia.org/reference/html/agents.html#agents-jvm)). 
  By default this is `/opt/jolokia/jolokia.properties`. If this file exists, it be will taken 
  as configuration and **any other config options are ignored**.  
* **AB_JOLOKIA_HOST** : Host address to bind to (Default: `0.0.0.0`)
* **AB_JOLOKIA_PORT** : Port to use (Default: `8778`)
* **AB_JOLOKIA_USER** : User for authentication. By default authentication is switched off.
* **AB_JOLOKIA_PASSWORD** : Password for authentication. By default authentication is switched off.
* **AB_JOLOKIA_ID** : Agent ID to use (`$HOSTNAME` by default, which is the container id)
* **AB_JOLOKIA_OPTS**  : Additional options to be appended to the agent opts. They should be given in the format 
  "key=value,key=value,..."

Some options for integration in various environments

* **AB_JOLOKIA_AUTH_OPENSHIFT** : Switch on OAuth2 authentication for OpenShift. The value of this parameter must be the OpenShift API's 
  base URL (e.g. `https://localhost:8443/osapi/v1/`)

#### jmx_exporter configuration 

* **AB_JMX_EXPORTER_OPTS** : Configuration to use for `jmx_exporter` (in the format `<port>:<path to config>`)
* **AB_JMX_EXPORTER_PORT** : Port to use for the JMX Exporter. Default: `9779`
* **AB_JMX_EXPORTER_CONFIG** : Path to configuration to use for `jmx_exporter`: Default: `/opt/agent-bond/jmx_exporter_config.json`

### Startup Script /run-java.sh

The default command for this image is `/run-java.sh`. Its purpose it
to fire up Java applications which are provided as fat-jars, including
all dependencies or more classical from a main class, where the
classpath is build up from all jars within a directory.x1

The script can be influenced by the following environment variables:

* **JAVA_APP_DIR** the directory where all JAR files can be
  found. This is `/app` by default.
* **JAVA_WORKDIR** working directory from where to start the JVM. By
  default it is `$JAVA_APP_DIR`
* **JAVA_OPTIONS** options to add when calling `java`
* **JAVA_MAIN_CLASS** A main class to use as argument for `java`. When
  this environment variable is given, all jar files in `$JAVA_APP_DIR`
  are added to the classpath as well as `$JAVA_APP_DIR` and
  `JAVA_WORKDIR` themselves, too.
* **JAVA_APP_JAR** A jar file with an appropriate mainfest so that it
  can be started with `java -jar`. If given it takes precedence of
  `$JAVA_MAIN_CLASS`. In addition `$JAVA_APP_DIR` and `$JAVA_WORKDIR`
  are added to the classpath, too. 

If neither `$JAVA_APP_JAR` nor `$JAVA_MAIN_CLASS` is given,
`$JAVA_APP_DIR` is checked for a single JAR file which is taken as
`$JAVA_APP_JAR`. If no or more then one jar file is found, the script
throws an error. 

Any arguments given during startup are taken over as arguments to the
Java call. E.g. a `docker run myimage-based-on-java arg1 arg2` will
hand over the arguments to the Java application.

### Versions:

* Base-Image: **Alpine undefined**
* Java: **OpenJDK 7 1.7.0** (Java Development Kit (JDK))
* Agent-Bond: **0.1.0** (Jolokia 1.3.1, jmx_exporter 0.3-SNAPSHOT)
