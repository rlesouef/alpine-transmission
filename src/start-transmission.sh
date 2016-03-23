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

if [ -z "${REMOVE_AFTER}" ]; then
	#there is 86400 seconds in a day
	REMOVE_AFTER=$((REMOVE_AFTER*86400))

		# Template a cronjob to delete the files if they are older than a month
	cat <<EOF >/etc/periodic/weekly/delete_old_files
  	#!/bin/sh

  	set -e

	now=\$(date +%s)

	for file in /transmission/downloads/*
	do
		dateFile=\$(stat -c%Y \$file)
		diff=\$((now - dateFile))

		if [ \$diff -gt $REMOVE_AFTER ]; then
			rm -rf \$file
		fi
	done
EOF
fi

chmod +x /etc/periodic/weekly/delete_old_files


exec /usr/bin/transmission-daemon --foreground --config-dir /etc/transmission-daemon
