FROM {{= fp.param.base }}
{{= fp.block("java-pkg-" + fp.param.base) || ''}}{{= fp.block("java-pkg-" + fp.param.base + "-" + fp.param.version) || ''}}
{{= fp.block("agent-bond") }}

ADD run-java.sh /
RUN mkdir /app \
 && chmod 755 /run-java.sh

CMD [ "/run-java.sh" ]
