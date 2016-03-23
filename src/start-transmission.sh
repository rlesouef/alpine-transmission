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


# Template a cronjob to delete the files if they are older than a month
cat <<EOF >/etc/periodic/monthly/reissue
  #!/bin/sh

  set -e

	now=$(date +%s)

	for file in /transmission/downloads/*
	do
		dateFile=$(stat -c%Y $file)
		diff=$((now - dateFile))

		# there is 2592000 seconds in 1 month.
		if [ $diff -gt 2592000 ]; then
			rm -rf $file
		fi
	done
EOF

chmod +x /etc/periodic/weekly/reissue


exec /usr/bin/transmission-daemon --foreground --config-dir /etc/transmission-daemon
