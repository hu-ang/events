#!/bin/bash

export MIX_ENV=prod
export PORT=4567


CFGD=$(readlink -f ~/.config/events)

if [ ! -e "$CFGD/base" ]; then
	echo "run deploy first"
	exit 1
fi

DB_PASS=$(cat "$CFGD/db_pass")
export DATABASE_URL=ecto://photos$DB_PASS@localhost/events_prod

SECRET_KEY_BASE=$(cat "$CFGD/base")
export SECRET_KEY_BASE

#_build/prod/rel/practice/bin/practice stop || true

echo "Starting app..."

_build/prod/rel/events/bin/events start

# TODO: Add a systemd service file
#       to start your app on system boot.

