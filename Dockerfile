FROM ubuntu:latest
LABEL maintainer="armen@kriation.com"
ARG BUILD_DATE
ARG BEDROCK_VERSION
ARG BEDROCK_SERVER_NAME="Dedicated Server"
ARG BEDROCK_GAMEMODE=survival
ARG BEDROCK_DIFFICULTY=easy
ARG BEDROCK_CHEATS=false
ARG BEDROCK_MAXPLAYERS=10
ARG BEDROCK_ONLINE=true
ARG BEDROCK_WHITELIST=false
ARG BEDROCK_IPV4_PORT=19132
ARG BEDROCK_VIEWDIST=32
ARG BEDROCK_TICKDIST=4
ARG BEDROCK_PLAYERTO=30
ARG BEDROCK_MAXTHREADS=8
ARG BEDROCK_LEVELNAME="Bedrock Level"
ARG BEDROCK_LEVELSEED
ARG BEDROCK_DEFAULTPERM=member
ARG BEDROCK_TEXTUREPACK=false
LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="Minecraft Bedrock Server" \
  org.label-schema.version=$BEDROCK_VERSION \
  org.label-schema.url="https://github.com/kriation/minecraft-bedrock" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.title="Minecraft Bedrock Server" \
  org.opencontainers.image.version=$BEDROCK_VERSION \
  org.opencontainers.image.url="https://github.com/kriation/minecraft-bedrock"
ENV BEDROCK_VERSION=${BEDROCK_VERSION} \
	BEDROCK_SERVER_NAME=${BEDROCK_SERVER_NAME} \
	BEDROCK_GAMEMODE=${BEDROCK_GAMEMODE} \
	BEDROCK_DIFFICULTY=${BEDROCK_DIFFICULTY} \
	BEDROCK_CHEATS=${BEDROCK_CHEATS} \
	BEDROCK_MAXPLAYERS=${BEDROCK_MAXPLAYERS} \
	BEDROCK_ONLINE=${BEDROCK_ONLINE} \
	BEDROCK_WHITELIST=${BEDROCK_WHITELIST} \
	BEDROCK_IPV4_PORT=${BEDROCK_IPV4_PORT} \
	BEDROCK_VIEWDIST=${BEDROCK_VIEWDIST} \
	BEDROCK_TICKDIST=${BEDROCK_TICKDIST} \
	BEDROCK_PLAYERTO=${BEDROCK_PLAYERTO} \
	BEDROCK_MAXTHREADS=${BEDROCK_MAXTHREADS} \
	BEDROCK_LEVELNAME=${BEDROCK_LEVELNAME} \
	BEDROCK_LEVELSEED=${BEDROCK_LEVELSEED} \
	BEDROCK_DEFAULTPERM=${BEDROCK_DEFAULTPERM} \
	BEDROCK_TEXTUREPACK=${BEDROCK_TEXTUREPACK}
WORKDIR /tmp
RUN apt-get update && \
	apt-get -y install curl unzip && \
	curl -L https://minecraft.azureedge.net/bin-linux/bedrock-server-${BEDROCK_VERSION}.zip \
  -o bedrock.zip && \
	unzip bedrock.zip -d bedrock && \
	useradd -d /opt/bedrock -M -U bedrock && \
	mv /tmp/bedrock /opt/ && \
	mkdir /opt/bedrock/worlds
COPY bin/bedrock-entrypoint.sh /opt/bedrock
COPY config/* /opt/bedrock/
RUN chown -R bedrock:bedrock /opt/bedrock && \
  chmod +x /opt/bedrock/bedrock_server
WORKDIR /opt/bedrock
EXPOSE $BEDROCK_IPV4_PORT/udp
VOLUME /opt/bedrock/worlds
USER bedrock
RUN sed -i 's/\(server-port=\)[[:print:]]*/\1'"$BEDROCK_IPV4_PORT"'/g' server.properties
ENTRYPOINT ["/opt/bedrock/bedrock-entrypoint.sh"]
