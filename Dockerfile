FROM ubuntu
ENV BEDROCK_VERSION 1.8.0.24
ARG BEDROCK_IPV4_PORT=19132
ARG BEDROCK_IPV6_PORT=19133
ENV BEDROCK_IPV4_PORT=${BEDROCK_IPV4_PORT:-19132} \
	BEDROCK_IPV6_PORT=${BEDROCK_IPV6_PORT:-19133}
WORKDIR /tmp
RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install curl unzip && \
	curl -o bedrock.zip https://minecraft.azureedge.net/bin-linux/bedrock-server-1.8.0.24.zip && \
	unzip bedrock.zip -d bedrock && \
	useradd -d /opt/bedrock -M -U bedrock && \
	mv /tmp/bedrock /opt/
COPY bin/bedrock-entrypoint.sh /opt/bedrock
COPY config/* /opt/bedrock
RUN	chown -R bedrock:bedrock /opt/bedrock
WORKDIR /opt/bedrock
EXPOSE $BEDROCK_IPV4_PORT $BEDROCK_IPV6_PORT
VOLUME /opt/bedrock/worlds
USER bedrock
RUN sed -i 's/\(server-port=\)[[:print:]]*/\1'"$BEDROCK_IPV4_PORT"'/g' server.properties && \
	sed -i 's/\(server-portv6=\)[[:print:]]*/\1'"$BEDROCK_IPV6_PORT"'/g' server.properties
ENTRYPOINT ["/opt/bedrock/bedrock-entrypoint.sh"]
