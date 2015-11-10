FROM ubuntu:14.04

RUN apt-get -y update &&\
    apt-get -y upgrade &&\
    apt-get -y install pwgen &&\
    apt-get clean

ARG VERSION=1.2.10

ADD https://github.com/mumble-voip/mumble/releases/download/${VERSION}/murmur-static_x86-${VERSION}.tar.bz2 /build/

RUN cd /build &&\
    tar -xjvf murmur-static_x86-${VERSION}.tar.bz2 &&\
    cp /build/murmur-static_x86-${VERSION}/murmur.x86 /usr/sbin/murmur &&\
    rm -r /build

# === GENERATE SUPERUSER PASSWORD. SEE LOGS FOR THE PASSWORD ===
RUN pwgen -c -n -1 15 > /superuser_password
RUN apt-get -y remove pwgen && apt-get -y autoremove && apt-get clean

# Touch murmur.sqlite, so murmur uses /root/murmur.sqlite as
# the database
RUN touch /etc/murmur.sqlite
COPY ./murmur.ini /etc/murmur.ini

VOLUME /root

EXPOSE 64738
CMD cat /superuser_password &&\
    mkdir -p /root/murmur &&\
    cp -n /etc/murmur.ini /root/murmur/murmur.ini &&\
    murmur -ini /root/murmur/murmur.ini -readsupw < /superuser_password &&\
    murmur -ini /root/murmur/murmur.ini -fg
