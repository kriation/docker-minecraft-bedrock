# Minecraft Bedrock on Ubuntu
This repository contains the required artifacts to build a Minecraft Bedrock
container image that is designed to run using container orchestration best
practices. By design, the entrypoint script tests for the existance of container
environment variables and applies them to the server.properties required for
server startup. This process ensures that the container can be customized at
instantiation versus requiring a rebuild of the image. 

## Usage
The minimal requirements to run the container are:
```
[~] docker run -P -v [hostdir]:/opt/bedrock/worlds kriation/minecraft-bedrock:latest
```
This will instantiate a container exposing the service port (default 19132/udp)
to a random host port and creating a bind mount to a host directory (as
specified by replacing [hostdir]) against the worlds directory inside of the
running container. The bind mount of the worlds directory provides the ability
to backup the contents from the host (or through another container).

## Customization
At instantiation, the container can be customized by passing any of the
variables below:
| Environment Variable | Minecraft Server Property | Default Value |
| -------------------- | ------------------------- | ------------- |
| BEDROCK_SERVER_NAME  | server-name | Dedicated Server |
| BEDROCK_GAMEMODE | gamemode | survival |
| BEDROCK_DIFFICULTY | difficulty | easy |
| BEDROCK_CHEATS | allow-cheats | false |
| BEDROCK_MAXPLAYERS | max-players | 10 |
| BEDROCK_ONLINE | online-mode | true |
| BEDROCK_WHITELIST | white-list | false |
| BEDROCK_IPV4_PORT | server-port | 19132 |
| BEDROCK_VIEWDIST | view-distance | 32 |
| BEDROCK_TICKDIST | tick_distance | 4 |
| BEDROCK_PLAYERTO | player-idle-timeout | 30 |
| BEDROCK_MAXTHREADS | max-threads | 8 |
| BEDROCK_LEVELNAME | level-name | Bedrock Level |
| BEDROCK_LEVELSEED | level-seed | <empty> |
| BEDROCK_DEFAULTPERM | default-player-permission-level | member |
| BEDROCK_TEXTUREPACK | texturepack-required | false |

## Caveats
If you modify the service port using BEDROCK_IPV4_PORT at container
instantiation time (versus at container build time), then you will have to
export the port manually. For example, if I change the service port to 19100,
then I will have to instantiate the container with the following:
```
[~] docker run -e BEDROCK_IPV4_PORT=19100 -p 19100:19100/udp -v [hostdir]:/opt/bedrock/worlds
kriation/minecraft-bedrock:latest
```
