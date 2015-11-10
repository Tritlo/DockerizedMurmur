# Dockerized mumble

This defines a dockerized mumble server. To run it, simply build it with
    
    docker build --rm -t mpgis/mumble .

and run with

    docker run -d --name mumble -p 64738:64738 -v $PWD/murmur/:/root/murmur/ mpgis/mumble

The default password is "mumble".

You can use another directory than $PWD for the mount if you want. You should then be able to change the config in the mount, and run

    docker restart mumble

To update the config on the server.
