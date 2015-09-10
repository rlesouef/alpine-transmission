[![logo](https://raw.githubusercontent.com/rlesouef/alpine-transmission/master/logo.png)](https://www.transmissionbt.com/)

docker-transmission
===================

Transmission Daemon Docker Container

Try it out
----------

Change transmission-daemon config:

    docker run -ti rlesouef/alpine-transmission vi /etc/transmission-daemon/settings.json

Create:

    mkdir -p /data/rlesouef/transmission/{downloads,incomplete}

Run the container:

    docker run -d --name transmission \
    -p 9091:9091 \
    -p 12345:12345 \
    -p 12345:12345/udp \
    -e "USERNAME=username" \
    -e "PASSWORD=password" \
    -v /data/rlesouef/transmission/downloads:/transmission/downloads \
    -v /data/rlesouef/transmission/incomplete:/transmission/incomplete \
    rlesouef/alpine-transmission

Connect to running container::

    docker exec -ti _name_container_ /bin/sh

Build it yourself
-----------------

    git clone https://github.com/rlesouef/alpine-transmission.git
    cd alpine-transmission
    docker build -t rlesouef/alpine-transmission .


```
mkdir -p /data/username/transmission/{downloads,incomplete,config}
```

Application container, don't forget to specify a password for `transmission` account and local directory for the downloads:

```
docker run -d  --name transmission \
-p 12345:12345 -p 12345:12345/udp -p 9091:9091 \
-v /data/username/transmission/downloads:/torrents/downloads \
-v /data/username/transmission/incomplete:/torrents/incomplete \
-v /data/username/transmission/config:/etc/transmission-daemon \
rlesouef/alpine-transmission

```
