#!/bin/sh

set -e
SETTINGS=/etc/transmission-daemon/settings.json

if [[ ! -f ${SETTINGS}.bak ]]; then
	# Checks for USERNAME variable
	if [ -z "$USERNAME" ]; then
	  echo >&2 'Please set an USERNAME variable (ie.: -e USERNAME=john).'
	  exit 1
	fi
	# Checks for PASSWORD variable
	if [ -z "$PASSWORD" ]; then
	  echo >&2 'Please set a PASSWORD variable (ie.: -e PASSWORD=hackme).'
	  exit 1
	fi
	# Modify settings.json
	sed -i.bak -e "s/#rpc-password#/$PASSWORD/" $SETTINGS
	sed -i.bak -e "s/#rpc-username#/$USERNAME/" $SETTINGS
fi

unset PASSWORD USERNAME

if [ -n "${REMOVE_AFTER}" ]; then
       echo "creating cron job"
	#there is 86400 seconds in a day
	REMOVE_AFTER=$((REMOVE_AFTER*86400))

		# Template a cronjob to delete the files if they are older than a month
	cat <<EOF >/etc/periodic/weekly/delete_old_files
  	#!/bin/sh

  	set -e

	now=\$(date +%s)

	for file in /transmission/downloads/*
	do
		dateFile=\$(stat -c%Y "\$file")
		diff=\$((now - dateFile))

		if [ \$diff -gt $REMOVE_AFTER ]; then
			rm -rf \$file
		fi
	done
EOF

chmod +x /etc/periodic/weekly/delete_old_files
fi

/usr/bin/transmission-daemon --foreground --config-dir /etc/transmission-daemon
