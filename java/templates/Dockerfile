FROM {{= it.param.base }}:{{= it.config.base.version }}
{{= it.blocks["java-pkg-" + it.param.base] || ''}}{{= it.blocks["java-pkg-" + it.param.base + "-" + it.param.version] || ''}}
{{= it.blocks["agent-bond"] }}

# Print out help message et al.
CMD java -jar /opt/agent-bond/agent-bond.jar
