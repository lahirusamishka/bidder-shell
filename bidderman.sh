#!/bin/bash

APP_PARAM=$1

config_function(){
    LIPA=$(ifconfig | grep -oE 'inet (addr:)?([0-9]{1,3}\.){3}[0-9]{1,3}' | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' | grep -v '127.0.0.1' | tail -n 1)
    ENV_FILE="../bidder-app/drop-in-docker-php/env/app.env";
    awk -v new_dbhost="$LIPA" -F '=' '$1=="DB_HOST" {$2=new_dbhost} $1=="WEB_SOCKET_HOST" {$2="ws://"new_dbhost":8090/"} $1=="WEB_SOCKET_API" {$2=new_dbhost":8090/"} 1' OFS='=' "$ENV_FILE" > temp && mv temp "$ENV_FILE"
    echo "successfully changed the ip address on app.env ip address:$LIPA"
}

openBrowser(){
    open "http://localhost:8000/"
    cd ../bidder-app/
    code .
}

open_app(){
    case "$OSTYPE" in
        solaris*) echo "SOLARIS" ;;
        darwin*)  openBrowser ;; 
        linux*)   openBrowser ;;
        bsd*)     echo "BSD" ;;
        msys*)    echo "WINDOWS" ;;
        cygwin*)  echo "ALSO WINDOWS" ;;
        *)        echo "unknown: $OSTYPE" ;;
    esac
}

case "$APP_PARAM" in
   "app_config") config_function 
   ;;
   "") open_app 
   ;;
esac

