During startup a directory specified by the environment variable `DEPLOY_DIR`
(*/maven* by default) is checked for .war files. If there
are any, they are linked into the *webapps/* directory for automatic
deployment. This plays nicely with the Docker maven plugin from
https://github.com/rhuss/docker-maven-plugin/ and its 'assembly' mode which
can automatically create Docker data container with Maven artifacts
exposed from a directory */maven*.

### Agent Bond

For this image [Agent Bond](https://github.com/fabric8io/agent-bond) is enabled. 
Agent Bond exports metrics from [Jolokia](http://www.jolokia.org) and 
[jmx_exporter](https://github.com/prometheus/jmx_exporter).

{{= fp.block('agent-bond','readme',{ 'fp-no-files' : true }) }}

