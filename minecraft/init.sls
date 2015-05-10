include:
  - dropbox

minecraft-link:
  file.symlink:
    - name: /home/max/.minecraft/saves
    - target: /home/max/Dropbox/saves
    - makedirs: True
    - user: max

minecraft-jar:
  file.managed:
    - name: /home/max/.minecraft/Minecraft.jar
    - source: salt://minecraft/Minecraft.jar
    - user: max
