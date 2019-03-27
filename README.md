# pixelmon
Repository for a Docker image of the Pixelmon Minecraft mod

# Usage
Use ./run.sh or ./run-local.sh to run or use below setup for docker-compose

```
  pixelmon:
    container_name: pixelmon
    image: walthowd/pixelmon
    command: java -Dfml.queryResult=confirm -jar minecraft-forge.jar nogui
    ports:
      - 25565:25565
    volumes:
      - /opt/pixelmon/ops/ops.json:/opt/minecraft/ops.json
      - /opt/pixelmon/server.properties:/opt/minecraft/server.properties
      - /opt/pixelmon/config:/opt/minecraft/config
      - /opt/pixelmon/world:/opt/minecraft/world
    restart: on-failure
    environment:
      MINECRAFT_DIR: /opt/minecraft
 ```
