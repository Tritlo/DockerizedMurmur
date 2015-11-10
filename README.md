# Dockerized murmur (mumble server)

(Requires Docker 1.9+)

The docker hub for this repo can be found at
https://hub.docker.com/r/tritlo/murmur/

The github repo for this service can be found at 
https://github.com/Tritlo/DockerizedMurmur/tree/master

For reference on config of murmur, see http://wiki.mumble.info/wiki/Murmur.ini

This repo is on docker hub, so to run it, you can simply use

    docker run -d --name murmur -p=64738:64738 -p=64738:64738/udp -v /mnt/murmur/:/root/murmur/ tritlo/murmur

You can then go to the mount point (/mnt/murmur/ in the above) and change
murmur.ini to set the settings. To then update the config on the server,
run

    docker murmur restart

To build it locally, pull this repo and use:
    
    docker build --rm -t tritlo/murmur .

## SuperUser password

When the images is first launched, a generated SuperUser password is
generated, and can be found in the logs. These are viewed with

    docker logs murmur

To set the SuperUser password, you can run

    docker run -it --rm -v /mnt/murmur/:/root/murmur/ tritlo/murmur /bin/murmur -readsupw

Where /mnt/murmur/ is your mount point. You will then be prompted to enter a
password, which will then be set as your SuperUser password.

## Server password

The default server password is "mumble", change this by updating

    serverpassword=mumble

in murmur.ini (at the mount point), and then run

    docker murmur restart

## Custom SSL

To use your own SSL certificate instead of having murmur autogenerate one,
update

    #sslCert=
    #sslKey=

in murmur.ini (at the mount point) into something like

    sslCert=/root/murmur/ssl/fullchain.pem
    sslKey=/root/murmur/ssl/privkey.pem

and then place your keys into /mnt/murmur/ssl,
or wherever your mount point is.

Then run 

    docker murmur restart

to update the server.
