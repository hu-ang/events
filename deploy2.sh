#!/bin/bash


export SECRET_KEY_BASE=insecure
export MIX_ENV=prod
export PORT=4567

DB_PASS=`pwd`/cfg/.db_pass
if [ ! -e "$DB_PASS" ]; then
	echo "Setup database"
	exit 1
fi

export DATABASE_IRL=ecto://events_db:`cat $DB_PASS`/events

mix deps.get --only prod
mix compile

KEY=`pwd`/cfg/.base

if [ ! -e "$KEY" ]; then
	mix phx.gen.secret > "$KEY"
fi

SECRET_KEY_BASE=$(cat "$KEY")
export SECRET_KEY_BASE

mix ecto.migrate
npm install --prefix ./assets
npm run deploy --prefix ./assets
mix phx.digest

mix release

