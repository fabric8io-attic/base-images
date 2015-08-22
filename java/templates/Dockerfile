FROM {{= fp.config.base.from }}
{{= fp.block("java-pkg-" + fp.param.base) || ''}}{{= fp.block("java-pkg-" + fp.param.base + "-" + fp.param.version) || ''}}
{{= fp.block("agent-bond") }}
{{= fp.block("run-java-sh","/") }}

RUN mkdir /app \
 && chmod 755 /run-java.sh

CMD [ "/run-java.sh" ]
