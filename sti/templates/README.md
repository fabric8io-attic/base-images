# Java STI builder image

This is a STI builder image for Java builds whose result can be run
directly without any further application server. It's suited ideally
for microservices. The application can be either provided as an
executable FAT Jar or in the more classical with JARs on a flat
classpath with one Main-Class.

This image also provides an easy integration with [agent-bond][1]
which wraps an [Jolokia][2] and Prometheus [jmx_exporter][3]
agent. See below how to configure this.

The following environment variables can be used to influence the
behaviour of this builder image:

## Build-Time

* `STI_DIR` Base STI dir (default: `/tmp`)
* `STI_SOURCE_DIR` Directory where the source should be copied to (default: `${STI_DIR}/src`)
* `STI_ARTIFACTS_DIR` Artifact directory used for incremental build (default: `${STI_DIR}/artifacts`)
* `OUTPUT_DIR` Directory where to find the generated artefacts (default: `${STI_SOURCE_DIR}/target`)
* `JAVA_APP_DIR` Where the application jar should be put to (default: `/app`)

## Run-Time

{{= fp.block('run-java-sh') }}

The environment variables are best set in `.sti/environment` top in
you project. This file is picked up bei STI during building and running.  

## Agent-Bond Options

Agent bond itself can be influenced via environment variables, too: 

{{= fp.block('agent-bond-options') }}

[1]: https://github.com/fabric8io/agent-bond
[2]: https://github.com/rhuss/jolokia
[3]: https://github.com/prometheus/jmx_exporter

