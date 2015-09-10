#!/bin/sh
set -e
SETTINGS=/etc/transmission-daemon/settings.json

if [[ ! -f ${SETTINGS}.bak ]]; then
    if [ -z $ADMIN_PASS ]; then
        echo Please provide a password for the 'transmission' user via the rpcpassword enviroment variable.
        exit 1
    fi
    sed -i.bak -e "s/#rpc-password#/$rpcpassword/" $SETTINGS
    sed -i.bak -e "s/#rpc-username#/$rpcusername/" $SETTINGS
fi

unset rpcpassword rpcusername
exec /usr/bin/supervisord
