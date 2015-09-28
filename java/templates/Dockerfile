FROM {{= fp.config.base.from + (fp.config.base.tagFromVersion ? ":" + fp.config.version.major : "") }}

USER root

{{= fp.block("java-pkg-" + fp.param.base) || ''}}{{= fp.block("java-pkg-" + fp.param.base + "-" + fp.param.version) || ''}}
{{= fp.block(fp.config.base.agent,"install") }}
{{= fp.block("run-java-sh","copy",{dest: "/"}) }}

RUN mkdir /app \
 && chmod 755 /run-java.sh

CMD [ "/run-java.sh" ]
