FROM ubuntu
ENV BEDROCK_VERSION 1.13.2.0
ARG BEDROCK_IPV4_PORT=19132
ENV BEDROCK_IPV4_PORT=${BEDROCK_IPV4_PORT:-19132}
WORKDIR /tmp
RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install curl unzip && \
	curl -o bedrock.zip https://minecraft.azureedge.net/bin-linux/bedrock-server-1.13.2.0.zip && \
	unzip bedrock.zip -d bedrock && \
	useradd -d /opt/bedrock -M -U bedrock && \
	mv /tmp/bedrock /opt/ && \
	mkdir /opt/bedrock/worlds
COPY bin/bedrock-entrypoint.sh /opt/bedrock
COPY config/* /opt/bedrock/
RUN	chown -R bedrock:bedrock /opt/bedrock
WORKDIR /opt/bedrock
EXPOSE $BEDROCK_IPV4_PORT/udp
VOLUME /opt/bedrock/worlds
USER bedrock
RUN sed -i 's/\(server-port=\)[[:print:]]*/\1'"$BEDROCK_IPV4_PORT"'/g' server.properties
ENTRYPOINT ["/opt/bedrock/bedrock-entrypoint.sh"]
