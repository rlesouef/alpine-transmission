#!/bin/sh
set -e
SETTINGS=/etc/transmission-daemon/settings.json

if [[ ! -f ${SETTINGS}.bak ]]; then
    if [ -z $PASSWORD ]; then
        echo Please provide a password for the 'transmission' user via the PASSWORD enviroment variable.
        exit 1
    fi
    sed -i.bak -e "s/#rpc-password#/$PASSWORD/" $SETTINGS
    sed -i.bak -e "s/#rpc-username#/$USERNAME/" $SETTINGS
fi

unset PASSWORD USERNAME

exec /usr/bin/transmission-daemon --foreground --config-dir /etc/transmission-daemon
