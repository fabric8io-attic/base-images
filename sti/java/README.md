# Fuse Java STI builder image

This is a STI builder image for Java builds whose result can be run
directly without any further application server. It's suited ideally
for microservices with a flat classpath (but not for "far jars") 

This image also provides an easy integration with an [Jolokia](https://github.com/rhuss/jolokia) 
agent. See below how to configure this.

The following environment variables can be used to influence the
behaviour of this builder image:

## Build Time

* **MAVEN_ARGS** Arguments to use when calling maven (default: `package hawt-app:build -DskipTests -e`). Please be sure to 
  run the `hawt-app:build` goal, otherwise the startup scripts won't work
* **MAVEN_MODULE** For a multi-module maven build this variable can pick a single module via its maven coordinates 
  (e.g. `io.fabric8.jube.images.fabric8:quickstart-java-simple-fatjar`)a
* **MAVEN_EXTRA_ARGS** Additional Maven  arguments, useful for temporary adding arguments like `-X`. These are added to `${MAVEN_ARGS}`
* **MAVEN_MIRROR_URL** If set to a Maven repository URL this URL is taken as a mirror for Maven central
* **MAVEN_CLEAR_REPO** If set then the Maven repository is removed after the artefact is build. This is useful for keeping
  the created application image small, but prevents *incremental* builds. Setting this variable implies also that dependent
  artifacts are copied into the application directory.

## Run Time

The run script can be influenced by the following environment variables:

* **JVM_ARGS**	Options that will be passed to the JVM. Use it to set options like the max JVM memory (-Xmx1G). 
* **JVM_DEBUG_ARGS**	JVM debug arguments
* **JVM_DEBUG**	If set to true, then enables JVM debug on port 5005
* **JVM_AGENT**	Set this to pass any JVM agent arguments for stuff like profilers
* **MAIN_ARGS**	Arguments that will be passed to you application's main method. Default: the arguments passed to the bin/run script.

The environment variables are best set in `.sti/environment` top in
you project. This file is picked up bei STI during building and running.  

#### Jolokia configuration

* **AB_JOLOKIA_OFF** : If set disables activation of Joloka (i.e. echos an empty value). By default, Jolokia is enabled.
* **AB_JOLOKIA_CONFIG** : If set uses this file (including path) as Jolokia JVM agent properties (as described 
  in Jolokia's [reference manual](http://www.jolokia.org/reference/html/agents.html#agents-jvm)). 
  By default this is `/opt/jolokia/jolokia.properties`. 
* **AB_JOLOKIA_HOST** : Host address to bind to (Default: `0.0.0.0`)
* **AB_JOLOKIA_PORT** : Port to use (Default: `8778`)
* **AB_JOLOKIA_USER** : User for authentication. By default authentication is switched off.
* **AB_JOLOKIA_PASSWORD** : Password for authentication. By default authentication is switched off.
* **AB_JOLOKIA_ID** : Agent ID to use (`$HOSTNAME` by default, which is the container id)
* **AB_JOLOKIA_OPTS**  : Additional options to be appended to the agent opts. They should be given in the format 
  "key=value,key=value,..."
* **AB_JOLOKIA_AUTH_OPENSHIFT** : Switch on authentication for OpenShift. 
