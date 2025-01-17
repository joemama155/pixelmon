FROM ubuntu:18.04

# install java 8
RUN apt-get update \
  && apt-get install -y software-properties-common \
  && add-apt-repository ppa:openjdk-r/ppa \
  && apt-get update \
  && apt-get install -y openjdk-8-jre wget

# working directory for minecraft
RUN mkdir /opt/minecraft

# fetch minecraft forge version 1.12.2 jar
RUN wget -O /opt/minecraft/minecraft-forge-installer.jar https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.5.2838/forge-1.12.2-14.23.5.2838-installer.jar 

# install minecraft server
RUN cd /opt/minecraft \
  && java -Xms1024M -Xmx2000M -jar /opt/minecraft/minecraft-forge-installer.jar --installServer

# accept the eula
RUN echo "eula=true" >> /opt/minecraft/eula.txt

# rename minecraft forge universal jar
RUN mv /opt/minecraft/forge-1.12.2-14.23.5.2838-universal.jar /opt/minecraft/minecraft-forge.jar

# install mods
#   Pixelmon-1.12.2-7.0.8.jar               (1.12.2 for the Forge version and 7.0.8 is the Pixelmon version)
#   extrautils2-1.12-1.9.9.jar              (1.12   for the Forge version and 1.9.9 is the extrautils2 verison)
#   refinedstorage-1.6.15.jar               (compatabile with Minecraft version 1.12.2)
#   PixelExtras-1.12.2-2.5.3-universal.jar  (1.12.2  for the Forge version and 2.5.3 is the PixelExtras version)
#   jei_1.12.2-4.15.0.271.jar               (1.12.2  for the Forge version and 4.15.0.271 is the JEI version)
RUN mkdir /opt/minecraft/mods \
  && mkdir /opt/minecraft/mods-available \
  && wget -O /opt/minecraft/mods/Pixelmon.jar https://dl.reforged.gg/3JCUH41 \
  #&& wget -O /opt/minecraft/mods-available/extrautils2.jar https://media.forgecdn.net/files/2678/374/extrautils2-1.12-1.9.9.jar \
  #&& wget -O /opt/minecraft/mods-available/refinedstorage.jar https://media.forgecdn.net/files/2745/458/refinedstorage-1.6.15.jar \
  #&& wget --user-agent Mozilla/4.0 -O /opt/minecraft/mods-available/PixelExtras.jar https://pixelmonmod.com/mirror/sidemods/PixelmonExtras/2.5.3/PixelExtras-1.12.2-2.5.3-universal.jar \
  #&& wget -O /opt/minecraft/mods-available/jei.jar https://edge.forgecdn.net/files/2691/438/jei_1.12.2-4.15.0.271.jar


# cleanup
RUN rm /opt/minecraft/minecraft-forge-installer.jar

COPY server.sh /opt/minecraft

EXPOSE 25565

WORKDIR /opt/minecraft

CMD [ "/bin/bash", "/opt/minecraft/server.sh" ]
