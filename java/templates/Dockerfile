FROM {{= it.param.base }}
{{= it.block("java-pkg-" + it.param.base) || ''}}{{= it.block("java-pkg-" + it.param.base + "-" + it.param.version) || ''}}
{{= it.block("agent-bond") }}

ADD run-java.sh /
RUN mkdir /app \
 && chmod 755 /run-java.sh

CMD [ "/run-java.sh" ]
