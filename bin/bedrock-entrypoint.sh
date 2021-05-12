#!/bin/bash
# bedrock.sh
# Script to start bedrock server

# Adjust server.properties based on environment variables
[ -n "$BEDROCK_SERVER_NAME" ] && \
  sed -i 's/\(server-name=\)[[:print:]]*/\1'"$BEDROCK_SERVER_NAME"'/g' server.properties
[ -n "$BEDROCK_GAMEMODE" ] && \
  sed -i 's/\(gamemode=\)[[:print:]]*/\1'"$BEDROCK_GAMEMODE"'/g' server.properties
[ -n "$BEDROCK_DIFFICULTY" ] && \
  sed -i 's/\(difficulty=\)[[:print:]]*/\1'"$BEDROCK_DIFFICULTY"'/g' server.properties
[ -n "$BEDROCK_CHEATS" ] && \
  sed -i 's/\(allow-cheats=\)[[:print:]]*/\1'"$BEDROCK_CHEATS"'/g' server.properties
[ -n "$BEDROCK_MAXPLAYERS" ] && \
  sed -i 's/\(max-players=\)[[:print:]]*/\1'"$BEDROCK_MAXPLAYERS"'/g' server.properties
[ -n "$BEDROCK_ONLINE" ] && \
  sed -i 's/\(online-mode=\)[[:print:]]*/\1'"$BEDROCK_ONLINE"'/g' server.properties
[ -n "$BEDROCK_WHITELIST" ] && \
  sed -i 's/\(white-list=\)[[:print:]]*/\1'"$BEDROCK_WHITELIST"'/g' server.properties
[ -n "$BEDROCK_IPV$_PORT" ] && \
  sed -i 's/\(server-port=\)[[:print:]]*/\1'"$BEDROCK_IPV4_PORT"'/g' server.properties
[ -n "$BEDROCK_VIEWDIST" ] && \
  sed -i 's/\(view-distance=\)[[:print:]]*/\1'"$BEDROCK_VIEWDIST"'/g' server.properties
[ -n "$BEDROCK_TICKDIST" ] && \
  sed -i 's/\(tick-distance=\)[[:print:]]*/\1'"$BEDROCK_TICKDIST"'/g' server.properties
[ -n "$BEDROCK_PLAYERTO" ] && \
  sed -i 's/\(player-idle-timeout=\)[[:print:]]*/\1'"$BEDROCK_PLAYERTO"'/g' server.properties
[ -n "$BEDROCK_MAXTHREADS" ] && \
  sed -i 's/\(max-threads=\)[[:print:]]*/\1'"$BEDROCK_MAXTHREADS"'/g' server.properties
[ -n "$BEDROCK_LEVELNAME" ] && \
  sed -i 's/\(level-name=\)[[:print:]]*/\1'"$BEDROCK_LEVELNAME"'/g' server.properties
[ -n "$BEDROCK_LEVELSEED" ] && \
  sed -i 's/\(level-seed=\)[[:print:]]*/\1'"$BEDROCK_LEVELSEED"'/g' server.properties
[ -n "$BEDROCK_DEFAULTPERM" ] && \
  sed -i 's/\(default-player-permission-level=\)[[:print:]]*/\1'"$BEDROCK_DEFAULTPERM"'/g' server.properties
[ -n "$BEDROCK_TEXTUREPACK" ] && \
  sed -i 's/\(texturepack-required=\)[[:print:]]*/\1'"$BEDROCK_TEXTUREPACK"'/g' server.properties

LD_LIBRARY_PATH=. /opt/bedrock/bedrock_server
