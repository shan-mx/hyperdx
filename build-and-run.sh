#!/bin/bash

# Check if URL parameter is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 url"
  exit 1
fi

# Get the new URL from the command line argument
new_url=$1

# Replace the URL in the .env file
sed -i "s|HYPERDX_API_URL=.*|HYPERDX_API_URL=$new_url|g" .env
sed -i "s|HYPERDX_APP_URL=.*|HYPERDX_APP_URL=$new_url|g" .env

echo "API and APP URL set to: $new_url"

make build-local || exit 1

echo "Build successful"

docker compose up -d || exit 1

docker builder prune -a

echo "HyperDX is running at $new_url:8080"