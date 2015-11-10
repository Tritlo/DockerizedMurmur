docker stop mumble
docker rm mumble
docker run -d --name mumble -p 64738:64738 -v $PWD/murmur/:/root/murmur/ mpgis/mumble
