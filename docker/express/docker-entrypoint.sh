#!/bin/sh

echo "Execution du docker entrypoint"

if ["$NODE_ENV" == "development"]
then
  echo "dev ok"
  npm install
fi

npm run db:import

exec "$@"