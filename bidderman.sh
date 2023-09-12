#!/bin/bash

LIPA=$(ifconfig | grep -oE 'inet (addr:)?([0-9]{1,3}\.){3}[0-9]{1,3}' | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' | grep -v '127.0.0.1' | tail -n 1)
echo "Your local IP address - $LIPA"



ENV_FILE="../bidder-app/drop-in-docker-php/env/app.env";


# Ensure the variable is enclosed in double quotes
awk -v new_dbhost="$LIPA" -F '=' '$1=="DB_HOST" {$2=new_dbhost} $1=="WEB_SOCKET_HOST" {$2="ws://"new_dbhost":8090/"} $1=="WEB_SOCKET_API" {$2=new_dbhost":8090/"} 1' OFS='=' "$ENV_FILE" > temp && mv temp "$ENV_FILE"

echo "Done"