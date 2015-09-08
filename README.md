[![logo](https://raw.githubusercontent.com/dperson/transmission/master/logo.png)](https://www.transmissionbt.com/)

docker-transmission
===================

Transmission Daemon Docker Container

Application container, don't forget to specify a password for `transmission` account and local directory for the downloads:

```
docker run -d -p 12345:12345 -p 12345:12345/udp -p 9091:9091 --name transmission -v /srv/transmission/download:/download -v /srv/transmission/config:/etc/transmission-daemon rlesouef/alpine-transmission

```
