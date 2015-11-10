# Dockerized mumble

The docker hub for this repo can be found at
https://hub.docker.com/r/tritlo/mumble/

The github repo for this service can be found at 
https://github.com/Tritlo/DockerizedMumble/tree/master

This repo defines a dockerized mumble server. To run it, simply build it with
    
    docker build --rm -t tritlo/mumble .

and run with

    docker run -d --name mumble -p 64738:64738 -v $PWD/murmur/:/root/murmur/ tritlo/mumble

The default password is "mumble".

You can use another directory than $PWD for the mount if you want. You should then be able to change the config in the mount, and run

    docker restart mumble

To update the config on the server.
